import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../database/daos.dart';
import '../services/settings_service.dart';
import '../youtube/youtube_api_service.dart';
import '../youtube/live_chat_manager.dart';

/// The single AppDatabase instance provider.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase.instance;
});

/// YouTube API key — user can set this in settings.
final apiKeyProvider = StateProvider<String>((ref) => SettingsService.apiKey);

/// YouTube API service — depends on the API key.
final youtubeApiProvider = Provider<YouTubeApiService?>((ref) {
  final key = ref.watch(apiKeyProvider);
  if (key.isEmpty) return null;
  return YouTubeApiService(apiKey: key);
});

/// The LiveChatManager — always available.
/// Uses API mode when a key is provided, otherwise scrape mode.
final liveChatManagerProvider = Provider<LiveChatManager>((ref) {
  final api = ref.watch(youtubeApiProvider);
  final db = ref.read(databaseProvider);

  final manager = LiveChatManager(
    api: api,
    db: db,
    mode: api != null ? ChatMode.api : ChatMode.scrape,
  );
  ref.onDispose(() => manager.dispose());
  return manager;
});

/// Connection status stream.
final chatStatusProvider = StreamProvider<ChatConnectionStatus>((ref) {
  final manager = ref.watch(liveChatManagerProvider);
  return manager.statusStream;
});

/// Current liveChatId (when connected).
final liveChatIdProvider = Provider<String?>((ref) {
  final manager = ref.watch(liveChatManagerProvider);
  return manager.liveChatId;
});

/// Chat messages stream from the database (persistent, ordered).
final chatMessagesProvider =
    StreamProvider.family<List<ChatMessage>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.chatMessageDao.watchMessages(liveChatId);
});

/// Super chats stream from the database.
final superChatsProvider =
    StreamProvider.family<List<SuperChat>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.superChatDao.watchSuperChats(liveChatId);
});

/// First-time viewer channelIds in a liveChatId (exactly 1 message).
final firstTimeViewersProvider =
    StreamProvider.family<Set<String>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.chatMessageDao.watchFirstTimeViewers(liveChatId);
});

/// Viewer detail stream.
final viewerProvider = StreamProvider.family<Viewer?, String>((ref, channelId) {
  final db = ref.read(databaseProvider);
  return db.viewerDao.watchViewer(channelId);
});

final selectedOwnerChannelIdProvider = StateProvider<String>((ref) => '');

/// A viewer's chat messages (across all streams).
final viewerMessagesProvider =
    StreamProvider.family<List<ChatMessage>, String>((ref, channelId) {
  final db = ref.read(databaseProvider);
  final ownerChannelId = ref.watch(selectedOwnerChannelIdProvider);
  return db.chatMessageDao.watchViewerMessages(
    channelId,
    ownerChannelId: ownerChannelId,
  );
});

/// A viewer's super chats (across all streams).
final viewerSuperChatsProvider =
    StreamProvider.family<List<SuperChat>, String>((ref, channelId) {
  final db = ref.read(databaseProvider);
  final ownerChannelId = ref.watch(selectedOwnerChannelIdProvider);
  return db.superChatDao.watchViewerSuperChats(
    channelId,
    ownerChannelId: ownerChannelId,
  );
});

/// Viewer search query.
final viewerSearchQueryProvider = StateProvider<String>((ref) => '');

/// Viewer search results.
final viewerSearchResultsProvider = StreamProvider<List<Viewer>>((ref) {
  final query = ref.watch(viewerSearchQueryProvider);
  final ownerChannelId = ref.watch(selectedOwnerChannelIdProvider);
  final db = ref.read(databaseProvider);
  if (ownerChannelId.isNotEmpty) {
    return db.viewerDao.watchViewersByOwnerChannel(
      ownerChannelId,
      query: query,
    );
  }
  if (query.isEmpty) {
    return db.viewerDao.watchAllViewers();
  }
  return db.viewerDao.searchViewers(query);
});

final ownerChannelsProvider = StreamProvider<List<OwnerChannelSummary>>((ref) {
  final db = ref.read(databaseProvider);
  return db.liveStreamDao.watchDistinctOwnerChannels();
});

/// URL History.
final urlHistoryProvider = FutureProvider<List<LiveStream>>((ref) {
  final db = ref.read(databaseProvider);
  return db.liveStreamDao.recentStreams();
});

/// Theme mode state.
final themeModeProvider = StateProvider<bool>((ref) => SettingsService.isDark);

/// Always on top state (desktop).
final alwaysOnTopProvider =
    StateProvider<bool>((ref) => SettingsService.alwaysOnTop);

/// Locale state.
final localeProvider = StateProvider<String>((ref) => SettingsService.locale);

/// Preferred currency used for converted totals in dashboard.
final displayCurrencyProvider =
    StateProvider<String>((ref) => SettingsService.displayCurrency);

/// Super Chat filter status.
enum SuperChatFilter { all, unread, read }

final superChatFilterProvider =
    StateProvider<SuperChatFilter>((ref) => SuperChatFilter.all);

/// Super Chat sort mode.
enum SuperChatSort { time, amount, status }

final superChatSortProvider =
    StateProvider<SuperChatSort>((ref) => SuperChatSort.time);

/// Super Chat search query.
final superChatSearchProvider = StateProvider<String>((ref) => '');

/// Selected viewer for detail panel.
final selectedViewerIdProvider = StateProvider<String?>((ref) => null);

/// Aggregate stat providers (no row limit — use SQL COUNT/SUM).
final messageCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.chatMessageDao.watchMessageCount(liveChatId);
});

final uniqueViewerCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.chatMessageDao.watchUniqueViewerCount(liveChatId);
});

final superChatCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.superChatDao.watchSuperChatCount(liveChatId);
});

final totalSuperChatAmountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.superChatDao.watchTotalAmountMicros(liveChatId);
});

/// Membership events stream from the database.
final membershipsProvider =
    StreamProvider.family<List<Membership>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.membershipDao.watchMemberships(liveChatId);
});

/// Membership count for a liveChatId.
final membershipCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.membershipDao.watchMembershipCount(liveChatId);
});

/// New member count for a liveChatId.
final newMemberCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.membershipDao.watchNewMemberCount(liveChatId);
});

/// Total gifted membership count for a liveChatId.
final giftedMembershipCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.membershipDao.watchGiftCount(liveChatId);
});

/// Milestone count for a liveChatId.
final milestoneCountProvider =
    StreamProvider.family<int, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.membershipDao.watchMilestoneCount(liveChatId);
});

/// All viewers in a liveChatId as a map (single stream, efficient for chat list).
final chatViewersMapProvider =
    StreamProvider.family<Map<String, Viewer>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.viewerDao.watchChatViewers(liveChatId);
});

/// Memberships for a liveChatId as a map keyed by message id.
/// Used by the chat page to show months + level for milestone messages.
final membershipsByIdProvider =
    StreamProvider.family<Map<String, Membership>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.membershipDao
      .watchMemberships(liveChatId)
      .map((list) => {for (final m in list) m.id: m});
});

/// SuperChats for a liveChatId as a map keyed by message id.
/// Used by the chat page to look up amount/currency for SC tiles.
final superChatsByIdProvider =
    StreamProvider.family<Map<String, SuperChat>, String>((ref, liveChatId) {
  final db = ref.read(databaseProvider);
  return db.superChatDao
      .watchSuperChats(liveChatId)
      .map((list) => {for (final sc in list) sc.id: sc});
});

/// Display name mode for chat messages.
enum DisplayNameMode { usernameAndHandle, usernameOnly, handleOnly }

final displayNameModeProvider =
    StateProvider<DisplayNameMode>((ref) => SettingsService.displayNameMode);

/// Chat font size setting.
enum ChatFontSize { small, medium, large }

final chatFontSizeProvider =
    StateProvider<ChatFontSize>((ref) => SettingsService.chatFontSize);
