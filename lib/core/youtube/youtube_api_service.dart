import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

/// YouTube Data API v3 client for fetching live chat messages.
///
/// Requires an API key. Handles paginated polling via liveChatMessages.list.
class YouTubeApiService {
  static const _baseUrl = 'https://www.googleapis.com/youtube/v3';
  final String apiKey;
  final http.Client _client;

  YouTubeApiService({required this.apiKey, http.Client? client})
      : _client = client ?? http.Client();

  /// Fetches metadata for a given live video.
  Future<LiveStreamInfo> getLiveStreamInfo(String videoId) async {
    final uri = Uri.parse('$_baseUrl/videos').replace(queryParameters: {
      'part': 'liveStreamingDetails,snippet',
      'id': videoId,
      'key': apiKey,
    });

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw YouTubeApiException(
        'Failed to fetch video details',
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final items = data['items'] as List?;
    if (items == null || items.isEmpty) {
      throw YouTubeApiException('Video not found: $videoId');
    }

    final item = items[0] as Map<String, dynamic>;
    final liveChatId = item['liveStreamingDetails']?['activeLiveChatId'];
    if (liveChatId == null) {
      throw YouTubeApiException(
        'No active live chat found for video: $videoId',
      );
    }

    final snippet = item['snippet'] as Map<String, dynamic>?;
    return LiveStreamInfo(
      videoId: videoId,
      liveChatId: liveChatId as String,
      title: snippet?['title'] as String? ?? '',
      ownerChannelId: snippet?['channelId'] as String? ?? '',
      ownerChannelName: snippet?['channelTitle'] as String? ?? '',
    );
  }

  /// Polls live chat messages. Returns a [LiveChatPollResult] with messages
  /// and the next page token for subsequent polling.
  Future<LiveChatPollResult> pollMessages(
    String liveChatId, {
    String? pageToken,
  }) async {
    final params = {
      'part': 'id,snippet,authorDetails',
      'liveChatId': liveChatId,
      'maxResults': '200',
      'key': apiKey,
    };
    if (pageToken != null) {
      params['pageToken'] = pageToken;
    }

    final uri =
        Uri.parse('$_baseUrl/liveChat/messages').replace(queryParameters: params);

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw YouTubeApiException(
        'Failed to poll chat messages',
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final items = (data['items'] as List?) ?? [];

    final messages = items.map<LiveChatMessage>((item) {
      final snippet = item['snippet'] as Map<String, dynamic>;
      final author = item['authorDetails'] as Map<String, dynamic>;
      final type = snippet['type'] as String? ?? 'textMessageEvent';

      int? amountMicros;
      String? currency;
      String? tier;

      if (type == 'superChatEvent') {
        final scDetails =
            snippet['superChatDetails'] as Map<String, dynamic>?;
        if (scDetails != null) {
          amountMicros = scDetails['amountMicros'] as int?;
          currency = scDetails['currency'] as String?;
          tier = (scDetails['tier'] ?? '').toString();
        }
      } else if (type == 'superStickerEvent') {
        final ssDetails =
            snippet['superStickerDetails'] as Map<String, dynamic>?;
        if (ssDetails != null) {
          amountMicros = ssDetails['amountMicros'] as int?;
          currency = ssDetails['currency'] as String?;
          tier = (ssDetails['tier'] ?? '').toString();
        }
      }

      final messageText = type == 'superChatEvent'
          ? (snippet['superChatDetails']?['userComment'] ?? '') as String
          : type == 'superStickerEvent'
              ? ''
              : type == 'memberMilestoneChatEvent'
                  ? (snippet['memberMilestoneChatDetails']?['userComment'] ?? '') as String
                  : (snippet['displayMessage'] ?? '') as String;

      // Membership event fields
      int? milestoneMonths;
      int? giftCount;
      String? membershipLevel;
      if (type == 'memberMilestoneChatEvent') {
        milestoneMonths = snippet['memberMilestoneChatDetails']
            ?['memberMonth'] as int?;
        membershipLevel = snippet['memberMilestoneChatDetails']
            ?['memberLevelName'] as String?;
      }
      if (type == 'newSponsorEvent') {
        membershipLevel = snippet['newSponsorDetails']
            ?['memberLevelName'] as String?;
      }
      if (type == 'membershipGiftingEvent') {
        giftCount = snippet['membershipGiftingDetails']
            ?['giftMembershipsCount'] as int?;
        membershipLevel = snippet['membershipGiftingDetails']
            ?['giftMembershipsLevelName'] as String?;
      }

      return LiveChatMessage(
        id: item['id'] as String,
        type: type,
        authorChannelId: author['channelId'] as String,
        authorDisplayName: author['displayName'] as String,
        authorHandle: (author['channelUrl'] as String?)
                ?.split('/')
                .lastOrNull ??
            '',
        authorAvatarUrl: author['profileImageUrl'] as String? ?? '',
        messageText: messageText,
        publishedAt: DateTime.parse(snippet['publishedAt'] as String),
        amountMicros: amountMicros,
        currency: currency,
        tier: tier,
        isMember: author['isChatSponsor'] as bool? ?? false,
        milestoneMonths: milestoneMonths,
        giftCount: giftCount,
        membershipLevel: membershipLevel,
      );
    }).toList();

    return LiveChatPollResult(
      messages: messages,
      nextPageToken: data['nextPageToken'] as String?,
      pollingIntervalMillis:
          (data['pollingIntervalMillis'] as int?) ?? 5000,
    );
  }

  /// Fetches the current concurrent viewer count for a live video.
  /// Returns null if the stream is not live or the field is absent.
  Future<int?> getConcurrentViewers(String videoId) async {
    final uri = Uri.parse('$_baseUrl/videos').replace(queryParameters: {
      'part': 'liveStreamingDetails',
      'id': videoId,
      'key': apiKey,
    });
    try {
      final response = await _client.get(uri);
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final items = data['items'] as List?;
      if (items == null || items.isEmpty) return null;
      final raw = items[0]['liveStreamingDetails']?['concurrentViewers'];
      if (raw == null) return null;
      return int.tryParse(raw.toString());
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _client.close();
  }
}

class YouTubeApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  YouTubeApiException(this.message, {this.statusCode, this.body});

  @override
  String toString() =>
      'YouTubeApiException: $message (status=$statusCode)';
}
