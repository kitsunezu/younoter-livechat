import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'models.dart';

/// Scrape-based YouTube Live Chat client that does NOT require an API key.
///
/// Fetches the public live chat replay/live page and extracts messages
/// from the initial data JSON embedded in the HTML.
class YouTubeScrapeService {
  final http.Client _client;
  String? _continuation;
  String? _apiKey; // innertube key extracted from page
  String? _clientVersion;
  bool _isReplay = false;

  /// Whether the current session is a chat replay (archived stream).
  bool get isReplay => _isReplay;

  YouTubeScrapeService({http.Client? client})
      : _client = client ?? http.Client();

  /// Fetches video + chat page metadata and prepares for polling.
  Future<LiveStreamInfo> initLiveChat(String videoId) async {
    final watchResponse = await _client.get(
      Uri.parse('https://www.youtube.com/watch?v=$videoId'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    );

    if (watchResponse.statusCode != 200) {
      throw ScrapeException(
        'Failed to load watch page (status ${watchResponse.statusCode})',
      );
    }

    final watchBody = watchResponse.body;
    final streamInfo = _extractStreamInfo(videoId, watchBody);

    // Extract API key and client version from watch page (always available).
    _apiKey = _extractMatch(
      watchBody,
      RegExp(r'"INNERTUBE_API_KEY"\s*:\s*"([^"]+)"'),
    );
    _clientVersion = _extractMatch(
      watchBody,
      RegExp(r'"INNERTUBE_CLIENT_VERSION"\s*:\s*"([^"]+)"'),
    );

    // Try to find chat continuation from the watch page ytInitialData.
    // This works for both live and archived streams without extra requests.
    _tryExtractChatFromWatchPage(watchBody);

    // If no continuation from watch page, try the dedicated live chat page.
    if (_continuation == null) {
      final url =
          'https://www.youtube.com/live_chat?is_popout=1&v=$videoId';
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                  '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Accept-Language': 'en-US,en;q=0.9',
        },
      );

      if (response.statusCode == 200) {
        final body = response.body;

        _apiKey ??= _extractMatch(
          body,
          RegExp(r'"INNERTUBE_API_KEY"\s*:\s*"([^"]+)"'),
        );
        _clientVersion ??= _extractMatch(
          body,
          RegExp(r'"INNERTUBE_CLIENT_VERSION"\s*:\s*"([^"]+)"'),
        );

        final dataMatch = RegExp(
          r'window\["ytInitialData"\]\s*=\s*({.+?})\s*;',
        ).firstMatch(body);
        final altMatch = dataMatch ??
            RegExp(r'var\s+ytInitialData\s*=\s*({.+?})\s*;').firstMatch(body);

        if (altMatch != null) {
          final jsonData =
              jsonDecode(altMatch.group(1)!) as Map<String, dynamic>;
          _continuation = _findContinuation(jsonData);
        }
      }
    }

    // Still no continuation? Try the replay page for archived streams.
    if (_continuation == null) {
      await _tryReplayPage(videoId);
    }

    if (_apiKey == null) {
      throw ScrapeException('Could not find innertube API key in page');
    }

    if (_continuation == null) {
      throw ScrapeException(
        'No live chat continuation found. '
        'The stream may not be live or may not have chat replay.',
      );
    }

    return LiveStreamInfo(
      videoId: videoId,
      liveChatId: videoId,
      title: streamInfo.title,
      ownerChannelId: streamInfo.ownerChannelId,
      ownerChannelName: streamInfo.ownerChannelName,
    );
  }

  /// Poll for new messages using the innertube endpoint.
  Future<LiveChatPollResult> pollMessages() async {
    if (_apiKey == null || _continuation == null) {
      throw ScrapeException('Not initialized. Call initLiveChat first.');
    }

    final endpoint = _isReplay ? 'get_live_chat_replay' : 'get_live_chat';
    final url =
        'https://www.youtube.com/youtubei/v1/live_chat/$endpoint'
        '?key=$_apiKey&prettyPrint=false';

    final payload = {
      'context': {
        'client': {
          'clientName': 'WEB',
          'clientVersion': _clientVersion ?? '2.20240101.00.00',
        },
      },
      'continuation': _continuation,
    };

    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      throw ScrapeException(
        'Chat poll failed (status ${response.statusCode})',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    // Update continuation
    final continuationActions =
        data['continuationContents']?['liveChatContinuation']
            ?['continuations'] as List?;
    if (continuationActions != null && continuationActions.isNotEmpty) {
      final cont = continuationActions.first as Map<String, dynamic>;
      _continuation = cont['invalidationContinuationData']?['continuation'] ??
          cont['timedContinuationData']?['continuation'] ??
          cont['liveChatReplayContinuationData']?['continuation'];
    } else if (_isReplay) {
      _continuation = null; // Replay finished — no more continuations.
    }

    // Parse polling interval
    int pollingMs = 5000;
    if (continuationActions != null && continuationActions.isNotEmpty) {
      final cont = continuationActions.first as Map<String, dynamic>;
      final timeoutMs =
          cont['invalidationContinuationData']?['timeoutMs'] ??
              cont['timedContinuationData']?['timeoutMs'];
      if (timeoutMs != null) {
        pollingMs = int.tryParse(timeoutMs.toString()) ?? 5000;
      }
    }

    // Parse messages
    final actions = data['continuationContents']?['liveChatContinuation']
        ?['actions'] as List?;
    final messages = <LiveChatMessage>[];

    if (actions != null) {
      for (final action in actions) {
        final actionMap = action as Map<String, dynamic>;

        // Replay wraps items inside replayChatItemAction → actions[]
        final itemActions = _isReplay
            ? (actionMap['replayChatItemAction']?['actions'] as List?)
                ?.cast<Map<String, dynamic>>()
            : [actionMap];

        if (itemActions != null) {
          for (final a in itemActions) {
            final item = a['addChatItemAction']?['item']
                as Map<String, dynamic>?;
            if (item == null) continue;
            final msg = _parseItem(item);
            if (msg != null) messages.add(msg);
          }
        }
      }
    }

    return LiveChatPollResult(
      messages: messages,
      pollingIntervalMillis: _isReplay ? 0 : pollingMs,
      isFinished: _isReplay && _continuation == null,
    );
  }

  LiveChatMessage? _parseItem(Map<String, dynamic> item) {
    // Text message
    final textRenderer =
        item['liveChatTextMessageRenderer'] as Map<String, dynamic>?;
    if (textRenderer != null) {
      return _buildMessage(textRenderer, 'textMessageEvent');
    }

    // Paid message (Super Chat)
    final paidRenderer =
        item['liveChatPaidMessageRenderer'] as Map<String, dynamic>?;
    if (paidRenderer != null) {
      return _buildMessage(paidRenderer, 'superChatEvent');
    }

    // Paid sticker (Super Sticker)
    final stickerRenderer =
        item['liveChatPaidStickerRenderer'] as Map<String, dynamic>?;
    if (stickerRenderer != null) {
      return _buildMessage(stickerRenderer, 'superStickerEvent');
    }

    // New member (sponsor)
    final sponsorRenderer =
        item['liveChatSponsorshipsHeaderRenderer'] as Map<String, dynamic>?;
    if (sponsorRenderer != null) {
      return _buildMessage(sponsorRenderer, 'newSponsorEvent');
    }

    // Membership gifting
    final giftRenderer =
        item['liveChatSponsorshipsGiftPurchaseAnnouncementRenderer']
            as Map<String, dynamic>?;
    if (giftRenderer != null) {
      // The inner header has display info but lacks id/timestamp/author.
      // Merge outer renderer fields so _buildMessage gets correct data.
      final header = giftRenderer['header']
              ?['liveChatSponsorshipsHeaderRenderer']
          as Map<String, dynamic>?;
      if (header != null) {
        final merged = Map<String, dynamic>.from(header);
        merged['id'] ??= giftRenderer['id'];
        merged['timestampUsec'] ??= giftRenderer['timestampUsec'];
        merged['authorName'] ??= giftRenderer['authorName'];
        merged['authorExternalChannelId'] ??=
            giftRenderer['authorExternalChannelId'];
        merged['authorPhoto'] ??= giftRenderer['authorPhoto'];
        merged['authorEndpoint'] ??= giftRenderer['authorEndpoint'];
        merged['authorBadges'] ??= giftRenderer['authorBadges'];
        return _buildMessage(merged, 'membershipGiftingEvent');
      }
      return _buildMessage(giftRenderer, 'membershipGiftingEvent');
    }

    // New member or membership milestone
    final memberRenderer =
        item['liveChatMembershipItemRenderer'] as Map<String, dynamic>?;
    if (memberRenderer != null) {
      // Field mapping (confirmed from DOM inspection):
      //   headerPrimaryText → "已加入會員 18 個月" / "Member for 18 months"
      //   headerSubtext     → membership tier name, e.g. "食品衛生責任者"
      //   authorBadges tooltip → badge-tier label, e.g. "1 年" (NOT the level name)
      // Any parseable month count > 1 means this is a milestone, not a new member.
      final headerPrimaryText =
          _extractTextRuns(memberRenderer['headerPrimaryText']) ?? '';
      final parsedMonths = _parseMilestoneMonths(headerPrimaryText);
      final isMilestone = parsedMonths != null && parsedMonths > 1;
      return _buildMessage(
        memberRenderer,
        isMilestone ? 'memberMilestoneChatEvent' : 'newSponsorEvent',
      );
    }

    return null;
  }

  LiveChatMessage _buildMessage(Map<String, dynamic> renderer, String type) {
    final authorName =
        _extractTextRuns(renderer['authorName']) ?? 'Unknown';
    final authorChannelId =
        renderer['authorExternalChannelId'] as String? ?? '';
    final authorPhoto = _extractThumbnail(renderer['authorPhoto']);
    final messageText = _extractTextRuns(renderer['message']) ?? '';
    final timestampUsec =
        renderer['timestampUsec'] as String? ?? '0';
    final timestampMicros = int.tryParse(timestampUsec) ?? 0;
    final publishedAt = timestampMicros > 0
        ? DateTime.fromMicrosecondsSinceEpoch(timestampMicros)
        : DateTime.now();
    final id = renderer['id'] as String? ?? '';

    // Extract handle from authorEndpoint → browseEndpoint → canonicalBaseUrl
    // e.g. "/@handle"
    String authorHandle = '';
    final endpoint = renderer['authorEndpoint'] as Map<String, dynamic>?;
    if (endpoint != null) {
      final canonicalUrl = endpoint['browseEndpoint']
          ?['canonicalBaseUrl'] as String?;
      if (canonicalUrl != null && canonicalUrl.startsWith('/@')) {
        authorHandle = canonicalUrl.substring(2); // remove '/@'
      }
    }

    // If authorName looks like a handle (@xxx) and we don't have a separate
    // handle yet, treat it as a handle.
    String displayName = authorName;
    if (authorHandle.isEmpty && authorName.startsWith('@')) {
      authorHandle = authorName.substring(1);
    }

    int? amountMicros;
    String? currency;
    if (type == 'superChatEvent' || type == 'superStickerEvent') {
      final purchaseText =
          renderer['purchaseAmountText']?['simpleText'] as String?;
      if (purchaseText != null) {
        final parsed = _parseAmount(purchaseText);
        amountMicros = parsed.$1;
        currency = parsed.$2;
      }
    }

    // Check for member (sponsor) badge
    final authorBadges = renderer['authorBadges'] as List?;
    bool isMember = false;
    if (authorBadges != null) {
      for (final badge in authorBadges) {
        final badgeRenderer =
            (badge as Map<String, dynamic>)['liveChatAuthorBadgeRenderer']
                as Map<String, dynamic>?;
        if (badgeRenderer != null) {
          final iconType = badgeRenderer['icon']?['iconType'] as String?;
          if (iconType == 'MEMBER') {
            isMember = true;
            break;
          }
          // Custom thumbnails also indicate membership
          if (badgeRenderer['customThumbnail'] != null) {
            isMember = true;
            break;
          }
        }
      }
    }

    // Membership-specific fields
    int? milestoneMonths;
    int? giftCount;
    String membershipLevel = '';
    if (type == 'memberMilestoneChatEvent' || type == 'newSponsorEvent') {
      // headerPrimaryText contains "已加入會員 18 個月" / "Member for 18 months"
      final headerPrimaryText =
          _extractTextRuns(renderer['headerPrimaryText']) ?? '';
      final parsed = _parseMilestoneMonths(headerPrimaryText);
      if (parsed != null && parsed > 0) {
        milestoneMonths = parsed;
      }
      // headerSubtext is the tier/level name, e.g. "食品衛生責任者"
      final levelFromSubtext =
          _extractTextRuns(renderer['headerSubtext']) ?? '';
      if (levelFromSubtext.isNotEmpty) {
        membershipLevel = levelFromSubtext;
      }
      isMember = true;
    }
    if (type == 'membershipGiftingEvent') {
      // primaryText like "Gifted 5 memberships"
      final primaryText =
          _extractTextRuns(renderer['primaryText']) ?? '';
      final giftMatch = RegExp(r'(\d+)').firstMatch(primaryText);
      if (giftMatch != null) {
        giftCount = int.tryParse(giftMatch.group(1)!);
      }
    }

    // For super stickers, embed the sticker image URL as message content
    String finalMessageText = messageText;
    if (type == 'superStickerEvent' && finalMessageText.isEmpty) {
      final stickerUrl = _extractThumbnail(renderer['sticker']);
      if (stickerUrl != null) {
        finalMessageText = '\uFFFC$stickerUrl\uFFFC';
      }
    }

    // Use primaryText / headerPrimaryText as fallback message for membership events
    // (headerSubtext is the tier name, not message content)
    if (type == 'newSponsorEvent' ||
        type == 'membershipGiftingEvent' ||
        type == 'memberMilestoneChatEvent') {
      final primaryText = _extractTextRuns(renderer['primaryText']) ??
          _extractTextRuns(renderer['headerPrimaryText']) ??
          '';
      if (finalMessageText.isEmpty && primaryText.isNotEmpty) {
        finalMessageText = primaryText;
      }
    }

    return LiveChatMessage(
      id: id,
      type: type,
      authorChannelId: authorChannelId,
      authorDisplayName: displayName,
      authorHandle: authorHandle,
      authorAvatarUrl: authorPhoto ?? '',
      messageText: finalMessageText,
      publishedAt: publishedAt,
      amountMicros: amountMicros,
      currency: currency,
      isMember: isMember,
      milestoneMonths: milestoneMonths,
      giftCount: giftCount,
      membershipLevel: membershipLevel.isNotEmpty ? membershipLevel : null,
    );
  }

  /// Parses the actual member month count from milestone headerSubtext in any
  /// supported locale. Handles:
  ///   - "13 months" / "13個月" / "13个月" / "13ヶ月" / "13か月"
  ///   - "1 year" / "1年"        → 12 months
  ///   - "1 year, 1 month" / "1年1個月" → 13 months
  static int? _parseMilestoneMonths(String text) {
    // year + month (must check before lone-year to avoid partial match)
    final yearMonthMatch = RegExp(
      r'(\d+)\s*(?:years?|年)[,、\s]+(\d+)\s*(?:months?|ヶ月|か月|個月|个月)',
      caseSensitive: false,
    ).firstMatch(text);
    if (yearMonthMatch != null) {
      final years = int.tryParse(yearMonthMatch.group(1)!) ?? 0;
      final months = int.tryParse(yearMonthMatch.group(2)!) ?? 0;
      return years * 12 + months;
    }

    // months only
    final monthsMatch = RegExp(
      r'(\d+)\s*(?:months?|ヶ月|か月|個月|个月)',
      caseSensitive: false,
    ).firstMatch(text);
    if (monthsMatch != null) {
      return int.tryParse(monthsMatch.group(1)!);
    }

    // years only (e.g. "Member for 1 year")
    final yearMatch = RegExp(
      r'(\d+)\s*(?:years?|年)',
      caseSensitive: false,
    ).firstMatch(text);
    if (yearMatch != null) {
      return (int.tryParse(yearMatch.group(1)!) ?? 0) * 12;
    }

    return null;
  }

  String? _extractTextRuns(dynamic obj) {
    if (obj == null) return null;
    if (obj is Map<String, dynamic>) {
      final simpleText = obj['simpleText'] as String?;
      if (simpleText != null) return simpleText;

      final runs = obj['runs'] as List?;
      if (runs != null) {
        return runs.map((r) {
          final run = r as Map<String, dynamic>;
          // Text run
          if (run.containsKey('text')) return run['text'] ?? '';
          // Emoji run
          final emoji = run['emoji'] as Map<String, dynamic>?;
          if (emoji != null) {
            // Try to get image URL for custom/YT emojis
            final imageUrl = _extractThumbnail(emoji['image']);
            final emojiId = emoji['emojiId'] as String?;

            // If it's a standard Unicode emoji (short emojiId, no slash),
            // just use the text directly
            if (emojiId != null &&
                emojiId.isNotEmpty &&
                !emojiId.contains('/') &&
                emojiId.length <= 10) {
              return emojiId;
            }

            // Custom emoji — embed image URL marker
            if (imageUrl != null && imageUrl.isNotEmpty) {
              return '\uFFFC$imageUrl\uFFFC';
            }

            // Fallback to accessibility label
            final label = emoji['image']?['accessibility']
                ?['accessibilityData']?['label'] as String?;
            if (label != null && label.isNotEmpty) return label;
            // Fallback to shortcut name
            final shortcuts = emoji['shortcuts'] as List?;
            if (shortcuts != null && shortcuts.isNotEmpty) {
              return shortcuts.first as String;
            }
          }
          return '';
        }).join();
      }
    }
    return null;
  }

  String? _extractThumbnail(dynamic obj) {
    if (obj is Map<String, dynamic>) {
      final thumbnails = obj['thumbnails'] as List?;
      if (thumbnails != null && thumbnails.isNotEmpty) {
        var url = (thumbnails.last as Map<String, dynamic>)['url'] as String?;
        // Normalise protocol-relative URLs (e.g. //lh3.googleusercontent.com/…)
        if (url != null && url.startsWith('//')) {
          url = 'https:$url';
        }
        return url;
      }
    }
    return null;
  }

  (int?, String?) _parseAmount(String text) {
    // e.g. "$5.00", "¥500", "€10.00", "NT$100.00"
    final match = RegExp(r'([^\d]*?)\s*([\d,]+\.?\d*)').firstMatch(text);
    if (match == null) return (null, null);
    final currencySymbol = match.group(1)?.trim() ?? '';
    final amountStr = match.group(2)?.replaceAll(',', '') ?? '0';
    final amount = double.tryParse(amountStr) ?? 0.0;
    final micros = (amount * 1000000).round();
    return (micros, currencySymbol);
  }

  String? _extractMatch(String text, RegExp pattern) {
    return pattern.firstMatch(text)?.group(1);
  }

  LiveStreamInfo _extractStreamInfo(String videoId, String html) {
    // 1. Try ytInitialPlayerResponse → videoDetails (legacy, may still work
    //    on some page variants).
    final playerJson = _extractJsonVar(html, 'ytInitialPlayerResponse');
    if (playerJson != null) {
      try {
        final data = jsonDecode(playerJson) as Map<String, dynamic>;
        final videoDetails = data['videoDetails'] as Map<String, dynamic>?;
        final microformat = data['microformat']?['playerMicroformatRenderer']
            as Map<String, dynamic>?;
        if (videoDetails != null) {
          return LiveStreamInfo(
            videoId: videoId,
            liveChatId: videoId,
            title: videoDetails['title'] as String? ?? '',
            ownerChannelId: videoDetails['channelId'] as String? ?? '',
            ownerChannelName: videoDetails['author'] as String? ??
                microformat?['ownerChannelName'] as String? ??
                '',
          );
        }
      } catch (_) {
        // JSON decode failed — try next source.
      }
    }

    // 2. Try ytInitialData → twoColumnWatchNextResults (current YouTube
    //    layout as of 2025+).
    final dataJson = _extractJsonVar(html, 'ytInitialData');
    if (dataJson != null) {
      try {
        final data = jsonDecode(dataJson) as Map<String, dynamic>;
        final contents = (data['contents']
                ?['twoColumnWatchNextResults']
                ?['results']
                ?['results']
                ?['contents'] as List?)
            ?.cast<Map<String, dynamic>>();
        if (contents != null) {
          String? title;
          String? ownerChannelId;
          String? ownerChannelName;

          for (final item in contents) {
            // Video title
            final vpir = item['videoPrimaryInfoRenderer']
                as Map<String, dynamic>?;
            if (vpir != null) {
              final runs = vpir['title']?['runs'] as List?;
              if (runs != null && runs.isNotEmpty) {
                title = runs.map((r) => r['text'] as String).join();
              }
            }

            // Channel name + id
            final vsir = item['videoSecondaryInfoRenderer']
                as Map<String, dynamic>?;
            if (vsir != null) {
              final owner = vsir['owner']?['videoOwnerRenderer']
                  as Map<String, dynamic>?;
              if (owner != null) {
                final nameRuns = owner['title']?['runs'] as List?;
                if (nameRuns != null && nameRuns.isNotEmpty) {
                  ownerChannelName =
                      nameRuns.map((r) => r['text'] as String).join();
                  ownerChannelId = nameRuns.first['navigationEndpoint']
                      ?['browseEndpoint']?['browseId'] as String?;
                }
              }
            }
          }

          if (title != null && title.isNotEmpty) {
            return LiveStreamInfo(
              videoId: videoId,
              liveChatId: videoId,
              title: title,
              ownerChannelId: ownerChannelId ?? '',
              ownerChannelName: ownerChannelName ?? '',
            );
          }
        }
      } catch (_) {
        // JSON decode failed — try next source.
      }
    }

    // 3. Fallback: HTML meta tags.
    final document = html_parser.parse(html);
    final title = document
        .querySelector('meta[property="og:title"]')
        ?.attributes['content'] ??
      document.querySelector('title')?.text ??
      '';
    final ownerChannelId = document
            .querySelector('meta[itemprop="channelId"]')
            ?.attributes['content'] ??
        '';
    final ownerChannelName = document
            .querySelector('link[itemprop="name"]')
            ?.attributes['content'] ??
        '';

    return LiveStreamInfo(
      videoId: videoId,
      liveChatId: videoId,
      title: title,
      ownerChannelId: ownerChannelId,
      ownerChannelName: ownerChannelName,
    );
  }

  /// Robustly extract a JSON object assigned to [varName] from [html],
  /// handling nested braces and strings correctly (unlike simple regex).
  String? _extractJsonVar(String html, String varName) {
    final markers = [
      'var $varName = ',
      'window["$varName"] = ',
    ];

    for (final marker in markers) {
      final idx = html.indexOf(marker);
      if (idx == -1) continue;
      final jsonStart = idx + marker.length;
      if (jsonStart >= html.length || html.codeUnitAt(jsonStart) != 0x7B) {
        continue;
      }

      int depth = 0;
      bool inString = false;
      bool escape = false;
      for (int i = jsonStart; i < html.length; i++) {
        final c = html.codeUnitAt(i);
        if (escape) {
          escape = false;
          continue;
        }
        if (c == 0x5C /* \ */ && inString) {
          escape = true;
          continue;
        }
        if (c == 0x22 /* " */) {
          inString = !inString;
          continue;
        }
        if (inString) continue;
        if (c == 0x7B /* { */) {
          depth++;
        } else if (c == 0x7D /* } */) {
          depth--;
          if (depth == 0) return html.substring(jsonStart, i + 1);
        }
      }
    }
    return null;
  }

  /// Try to extract chat continuation from the watch page's ytInitialData.
  /// The watch page embeds conversationBar.liveChatRenderer with the
  /// continuation token for both live and archived (replay) streams.
  void _tryExtractChatFromWatchPage(String watchBody) {
    final jsonStr = _extractJsonVar(watchBody, 'ytInitialData');
    if (jsonStr == null) return;

    try {
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;

      // Path: contents → twoColumnWatchNextResults → conversationBar
      //       → liveChatRenderer → continuations
      final chatRenderer = data['contents']
          ?['twoColumnWatchNextResults']
          ?['conversationBar']
          ?['liveChatRenderer'] as Map<String, dynamic>?;
      if (chatRenderer == null) return;

      final continuations = chatRenderer['continuations'] as List?;
      if (continuations == null || continuations.isEmpty) return;

      for (final c in continuations) {
        final cont = c as Map<String, dynamic>;

        // Replay continuation (archived/VOD stream)
        final replayCont =
            cont['liveChatReplayContinuationData']?['continuation']
                as String?;
        if (replayCont != null) {
          _isReplay = true;
          _continuation = replayCont;
          return;
        }

        // Live continuations
        final liveCont =
            cont['reloadContinuationData']?['continuation'] as String? ??
                cont['invalidationContinuationData']?['continuation']
                    as String? ??
                cont['timedContinuationData']?['continuation'] as String?;
        if (liveCont != null) {
          _continuation = liveCont;
          return;
        }
      }
    } catch (_) {
      // Parse error — will fall through to live_chat page fetching.
    }
  }

  String? _findContinuation(Map<String, dynamic> data) {
    // Walk the JSON to find the continuation token
    final contents = data['contents']?['liveChatRenderer']
        ?['continuations'] as List?;
    if (contents != null && contents.isNotEmpty) {
      final cont = contents.first as Map<String, dynamic>;
      // Check for replay continuation (archived/VOD streams)
      final replayCont =
          cont['liveChatReplayContinuationData']?['continuation'] as String?;
      if (replayCont != null) {
        _isReplay = true;
        return replayCont;
      }
      return cont['invalidationContinuationData']?['continuation'] ??
          cont['timedContinuationData']?['continuation'] ??
          cont['reloadContinuationData']?['continuation'];
    }
    return null;
  }

  /// Try fetching live_chat_replay page for archived streams.
  Future<void> _tryReplayPage(String videoId) async {
    final url =
        'https://www.youtube.com/live_chat_replay?is_popout=1&v=$videoId';
    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    );
    if (response.statusCode != 200) return;

    final body = response.body;

    _apiKey ??= _extractMatch(
      body,
      RegExp(r'"INNERTUBE_API_KEY"\s*:\s*"([^"]+)"'),
    );
    _clientVersion ??= _extractMatch(
      body,
      RegExp(r'"INNERTUBE_CLIENT_VERSION"\s*:\s*"([^"]+)"'),
    );

    final dataStr = _extractJsonVar(body, 'ytInitialData');
    if (dataStr == null) return;

    try {
      final jsonData = jsonDecode(dataStr) as Map<String, dynamic>;
      _isReplay = true;
      _continuation = _findContinuation(jsonData);
    } catch (_) {
      // Ignore parse errors
    }
  }

  /// Fetches the current concurrent viewer count via the innertube
  /// `updated_metadata` endpoint.  Uses the API key / client version already
  /// captured during [initLiveChat].  Returns null when unavailable.
  Future<int?> getConcurrentViewers(String videoId) async {
    final apiKey = _apiKey;
    final clientVersion = _clientVersion ?? '2.20240101.00.00';
    final url = apiKey != null
        ? 'https://www.youtube.com/youtubei/v1/updated_metadata?key=$apiKey&prettyPrint=false'
        : 'https://www.youtube.com/youtubei/v1/updated_metadata?prettyPrint=false';
    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                  '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Accept-Language': 'en-US,en;q=0.9',
        },
        body: jsonEncode({
          'context': {
            'client': {
              'clientName': 'WEB',
              'clientVersion': clientVersion,
            },
          },
          'videoId': videoId,
        }),
      );
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final actions = data['actions'] as List?;
      if (actions == null) return null;
      for (final action in actions) {
        final vcAction =
            (action as Map<String, dynamic>)['updateViewershipAction'];
        if (vcAction == null) continue;
        final raw = vcAction['viewCount']?['videoViewCountRenderer']
            ?['originalViewCount'];
        if (raw != null) return int.tryParse(raw.toString());
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _client.close();
  }
}

class ScrapeException implements Exception {
  final String message;
  ScrapeException(this.message);

  @override
  String toString() => 'ScrapeException: $message';
}
