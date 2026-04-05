import 'dart:async';
import 'dart:math' show min;
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../database/database.dart';
import '../database/daos.dart';
import 'models.dart';
import 'username_resolver.dart';
import 'youtube_api_service.dart';
import 'youtube_scrape_service.dart';
import 'url_parser.dart';

/// Connection status for the live chat.
enum ChatConnectionStatus { disconnected, connecting, connected, error }

/// Mode of chat fetching.
enum ChatMode { api, scrape }

/// Manages the lifecycle of a live chat connection:
/// connect, poll, persist, disconnect.
/// Supports both official API (requires key) and scrape (no key) modes.
class LiveChatManager {
  final YouTubeApiService? _api;
  final YouTubeScrapeService _scrape;
  final AppDatabase _db;
  final ChatMode mode;

  Timer? _pollTimer;
  Timer? _viewerCountTimer;
  String? _liveChatId;
  String? _videoId;
  String? _nextPageToken;
  String? _currentOwnerChannelId;
  String? _currentOwnerChannelName;
  String? _currentStreamTitle;
  bool _useScrapeFallback = false;
  UsernameResolver? _usernameResolver;

  int? _currentViewers;
  int? _peakViewers;
  int? get currentViewers => _currentViewers;
  int? get peakViewers => _peakViewers;

  final _viewersController = StreamController<int?>.broadcast();
  Stream<int?> get peakViewersStream => _viewersController.stream;

  /// Whether the current session is loading archived chat replay.
  bool get isReplay =>
      (mode == ChatMode.scrape || _useScrapeFallback) && _scrape.isReplay;

  ChatConnectionStatus _status = ChatConnectionStatus.disconnected;
  ChatConnectionStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? get liveChatId => _liveChatId;
  String? get videoId => _videoId;
  String? get currentOwnerChannelId => _currentOwnerChannelId;
  String? get currentOwnerChannelName => _currentOwnerChannelName;
  String? get currentStreamTitle => _currentStreamTitle;

  final _statusController = StreamController<ChatConnectionStatus>.broadcast();
  Stream<ChatConnectionStatus> get statusStream => _statusController.stream;

  final _messageController =
      StreamController<List<LiveChatMessage>>.broadcast();
  Stream<List<LiveChatMessage>> get messageStream => _messageController.stream;

  LiveChatManager({
    YouTubeApiService? api,
    required AppDatabase db,
    this.mode = ChatMode.scrape,
  })  : _api = api,
        _scrape = YouTubeScrapeService(),
        _db = db;

  /// Connect to a YouTube live stream by URL.
  Future<void> connect(String url) async {
    final vid = extractVideoId(url);
    if (vid == null) {
      _setStatus(ChatConnectionStatus.error);
      _errorMessage = 'Invalid YouTube URL';
      return;
    }

    _videoId = vid;
    _setStatus(ChatConnectionStatus.connecting);
    _errorMessage = null;

    try {
      late final LiveStreamInfo streamInfo;
      if (mode == ChatMode.api && _api != null) {
        try {
          streamInfo = await _api.getLiveStreamInfo(vid);
          _liveChatId = streamInfo.liveChatId;
          _useScrapeFallback = false;
        } on YouTubeApiException {
          // No active live chat — fall back to scrape for archived streams.
          streamInfo = await _scrape.initLiveChat(vid);
          _liveChatId = 'scrape_$vid';
          _useScrapeFallback = true;
        }
      } else {
        streamInfo = await _scrape.initLiveChat(vid);
        _liveChatId = 'scrape_$vid';
      }

      _currentOwnerChannelId = streamInfo.ownerChannelId;
      _currentOwnerChannelName = streamInfo.ownerChannelName;
      _currentStreamTitle = streamInfo.title;

      // Save to URL history
      await _db.liveStreamDao.insertStream(LiveStreamsCompanion.insert(
        videoId: vid,
        liveChatId: Value(_liveChatId),
        title: Value(streamInfo.title),
        ownerChannelId: Value(streamInfo.ownerChannelId),
        ownerChannelName: Value(streamInfo.ownerChannelName),
        url: url.trim(),
      ));

      _setStatus(ChatConnectionStatus.connected);
      _usernameResolver = UsernameResolver(db: _db);
      _usernameResolver!.start();
      _startPolling();
    } on YouTubeApiException catch (e) {
      _errorMessage = e.message;
      _setStatus(ChatConnectionStatus.error);
    } on ScrapeException catch (e) {
      _errorMessage = e.message;
      _setStatus(ChatConnectionStatus.error);
    } catch (e) {
      _errorMessage = e.toString();
      _setStatus(ChatConnectionStatus.error);
    }
  }

  void disconnect() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _viewerCountTimer?.cancel();
    _viewerCountTimer = null;
    _nextPageToken = null;
    _liveChatId = null;
    _videoId = null;
    _currentOwnerChannelId = null;
    _currentOwnerChannelName = null;
    _currentStreamTitle = null;
    _useScrapeFallback = false;
    _currentViewers = null;
    _peakViewers = null;
    _usernameResolver?.stop();
    _usernameResolver = null;
    _setStatus(ChatConnectionStatus.disconnected);
  }

  void _setStatus(ChatConnectionStatus s) {
    _status = s;
    _statusController.add(s);
  }

  void _startPolling() {
    _poll(); // initial poll immediately
    _fetchViewerCount(); // initial fetch immediately
    // Re-fetch viewer count every 60 seconds.
    _viewerCountTimer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => _fetchViewerCount(),
    );
  }

  Future<void> _fetchViewerCount() async {
    final vid = _videoId;
    if (vid == null || _status != ChatConnectionStatus.connected) return;
    try {
      int? count;
      if (mode == ChatMode.api && _api != null && !_useScrapeFallback) {
        count = await _api.getConcurrentViewers(vid);
      } else {
        count = await _scrape.getConcurrentViewers(vid);
      }
      if (count != null && count > 0) {
        _currentViewers = count;
        if (_peakViewers == null || count > _peakViewers!) {
          _peakViewers = count;
          _viewersController.add(_peakViewers);
        }
      }
    } catch (_) {
      // Silently ignore — viewer count is best-effort.
    }
  }

  Future<void> _poll() async {
    if (_liveChatId == null || _status != ChatConnectionStatus.connected) {
      return;
    }

    final stopwatch = Stopwatch()..start();

    try {
      final LiveChatPollResult result;

      if (mode == ChatMode.api && _api != null && !_useScrapeFallback) {
        result = await _api.pollMessages(
          _liveChatId!,
          pageToken: _nextPageToken,
        );
        _nextPageToken = result.nextPageToken;
      } else {
        result = await _scrape.pollMessages();
      }

      if (result.messages.isNotEmpty) {
        await _persistMessages(result.messages);
        _messageController.add(result.messages);
      }

      // Replay finished — all archived messages have been loaded.
      if (result.isFinished) {
        return;
      }

      if (_liveChatId == null || _status != ChatConnectionStatus.connected) {
        return;
      }

      // For replay (archived streams): poll immediately to load fast.
      // For live streams: cap polling interval at 2 seconds for
      // responsiveness (server default is often 5s).
      final int targetMs;
      if (isReplay) {
        targetMs = 0;
      } else {
        targetMs = min(result.pollingIntervalMillis, 2000);
      }

      final remainingDelayMs =
          targetMs - stopwatch.elapsedMilliseconds;

      _pollTimer = Timer(
        Duration(milliseconds: remainingDelayMs > 0 ? remainingDelayMs : 0),
        _poll,
      );
    } on YouTubeApiException catch (e) {
      debugPrint('Poll error: $e');
      _pollTimer = Timer(const Duration(seconds: 10), _poll);
    } on ScrapeException catch (e) {
      debugPrint('Poll error: $e');
      _pollTimer = Timer(const Duration(seconds: 10), _poll);
    } catch (e) {
      debugPrint('Poll error: $e');
      _pollTimer = Timer(const Duration(seconds: 10), _poll);
    }
  }

  Future<void> _persistMessages(List<LiveChatMessage> messages) async {
    final liveChatId = _liveChatId;
    if (messages.isEmpty || liveChatId == null) return;

    final latestViewerEntries = <String, ViewerUpsertEntry>{};
    final chatEntries = <ChatMessagesCompanion>[];
    final superChatEntries = <SuperChatsCompanion>[];
    final membershipEntries = <MembershipsCompanion>[];

    for (final msg in messages) {
      latestViewerEntries[msg.authorChannelId] = ViewerUpsertEntry(
        channelId: msg.authorChannelId,
        displayName: msg.authorDisplayName,
        handle: msg.authorHandle.isNotEmpty ? msg.authorHandle : null,
        avatarUrl: msg.authorAvatarUrl.isNotEmpty ? msg.authorAvatarUrl : null,
      );

      chatEntries.add(ChatMessagesCompanion.insert(
        id: msg.id,
        liveChatId: liveChatId,
        channelId: msg.authorChannelId,
        displayName: msg.authorDisplayName,
        messageText: msg.messageText,
        type: Value(msg.type),
        isMember: Value(msg.isMember),
        publishedAt: msg.publishedAt,
      ));

      if (msg.isSuperChat) {
        superChatEntries.add(SuperChatsCompanion.insert(
          id: msg.id,
          liveChatId: liveChatId,
          channelId: msg.authorChannelId,
          displayName: msg.authorDisplayName,
          messageText: Value(msg.messageText),
          amountMicros: msg.amountMicros ?? 0,
          currency: msg.currency ?? 'USD',
          tier: Value(msg.tier ?? ''),
          type: Value(msg.type),
          publishedAt: msg.publishedAt,
        ));
      }

      if (msg.isMembershipEvent) {
        membershipEntries.add(MembershipsCompanion.insert(
          id: msg.id,
          liveChatId: liveChatId,
          channelId: msg.authorChannelId,
          displayName: msg.authorDisplayName,
          type: msg.type,
          messageText: Value(msg.messageText),
          milestoneMonths: Value(msg.milestoneMonths ?? 0),
          giftCount: Value(msg.giftCount ?? 0),
          membershipLevel: Value(msg.membershipLevel ?? ''),
          publishedAt: msg.publishedAt,
        ));
      }
    }

    await _db.transaction(() async {
      await _db.viewerDao.upsertViewersBatch(
        latestViewerEntries.values.toList(),
      );
      await _db.chatMessageDao.insertMessages(chatEntries);
      await _db.superChatDao.insertSuperChats(superChatEntries);
      await _db.membershipDao.insertMemberships(membershipEntries);
    });
  }

  void dispose() {
    disconnect();
    _scrape.dispose();
    _usernameResolver?.dispose();
    _statusController.close();
    _messageController.close();
    _viewersController.close();
  }
}
