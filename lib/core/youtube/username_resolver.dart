import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

import '../database/database.dart';

/// Gradually resolves real usernames for viewers by visiting their
/// YouTube channel pages (via handle).
///
/// YouTube live chat only provides handles; this service fetches the
/// actual display name from the channel page and stores it in the DB.
class UsernameResolver {
  final AppDatabase _db;
  final http.Client _client;
  Timer? _timer;

  /// Delay between each resolution request to avoid rate-limiting.
  static const _resolveInterval = Duration(seconds: 8);

  UsernameResolver({required AppDatabase db, http.Client? client})
      : _db = db,
        _client = client ?? http.Client();

  /// Start the background resolution loop.
  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(_resolveInterval, (_) => _resolveNext());
    // Also run once immediately.
    _resolveNext();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Pick the next viewer without a username and resolve it.
  Future<void> _resolveNext() async {
    try {
      final viewer = await _db.viewerDao.getNextViewerWithoutUsername();
      if (viewer == null) return;

      final handle = viewer.handle;
      if (handle == null || handle.isEmpty) return;

      final username = await fetchUsernameByHandle(handle);
      if (username != null && username.isNotEmpty) {
        await _db.viewerDao.updateUsername(viewer.channelId, username);
        debugPrint(
            'Resolved username for @$handle → $username');
      }
    } catch (e) {
      debugPrint('UsernameResolver error: $e');
    }
  }

  /// Fetch the real display name from a YouTube channel page.
  ///
  /// Visits `https://www.youtube.com/@handle` and extracts the channel
  /// title from the HTML meta tags.
  @visibleForTesting
  Future<String?> fetchUsernameByHandle(String handle) async {
    final uri = Uri.parse('https://www.youtube.com/@$handle');
    final response = await _client.get(uri, headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
              '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept-Language': 'en-US,en;q=0.9',
    });

    if (response.statusCode != 200) return null;

    final body = response.body;

    // Try <meta property="og:title" content="ChannelName">
    final doc = html_parser.parse(body);
    final ogTitle = doc.querySelector('meta[property="og:title"]');
    if (ogTitle != null) {
      final content = ogTitle.attributes['content'];
      if (content != null && content.isNotEmpty) {
        return content;
      }
    }

    // Fallback: <title>ChannelName - YouTube</title>
    final titleEl = doc.querySelector('title');
    if (titleEl != null) {
      final titleText = titleEl.text.trim();
      if (titleText.endsWith(' - YouTube')) {
        return titleText.substring(0, titleText.length - ' - YouTube'.length);
      }
    }

    return null;
  }

  void dispose() {
    stop();
    _client.close();
  }
}
