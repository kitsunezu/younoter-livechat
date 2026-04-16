import 'dart:convert';
import 'package:drift/drift.dart';
import 'tables.dart';
import 'database.dart';

part 'daos.g.dart';

class ViewerUpsertEntry {
  final String channelId;
  final String displayName;
  final String? handle;
  final String? avatarUrl;

  const ViewerUpsertEntry({
    required this.channelId,
    required this.displayName,
    this.handle,
    this.avatarUrl,
  });
}

@DriftAccessor(tables: [Viewers, ChatMessages, LiveStreams])
class ViewerDao extends DatabaseAccessor<AppDatabase> with _$ViewerDaoMixin {
  ViewerDao(super.db);

  Future<List<Viewer>> allViewers() => select(viewers).get();

  Stream<List<Viewer>> watchAllViewers({int limit = 200}) {
    return (select(viewers)
          ..orderBy([(t) => OrderingTerm.desc(t.lastSeen)])
          ..limit(limit))
        .watch();
  }

  Stream<Viewer?> watchViewer(String channelId) {
    return (select(viewers)..where((t) => t.channelId.equals(channelId)))
        .watchSingleOrNull();
  }

  Future<Viewer?> getViewer(String channelId) {
    return (select(viewers)..where((t) => t.channelId.equals(channelId)))
        .getSingleOrNull();
  }

  Future<void> upsertViewer({
    required String channelId,
    required String displayName,
    String? handle,
    String? avatarUrl,
  }) async {
    final existing = await getViewer(channelId);
    if (existing != null) {
      // Update name history if displayName changed
      List<String> history =
          (jsonDecode(existing.nameHistory) as List).cast<String>();
      if (existing.displayName != displayName &&
          !history.contains(existing.displayName)) {
        history.add(existing.displayName);
      }

      await (update(viewers)..where((t) => t.channelId.equals(channelId)))
          .write(ViewersCompanion(
        displayName: Value(displayName),
        handle: Value(handle),
        avatarUrl: Value(avatarUrl),
        nameHistory: Value(jsonEncode(history)),
        lastSeen: Value(DateTime.now()),
      ));
    } else {
      await into(viewers).insert(ViewersCompanion.insert(
        channelId: channelId,
        displayName: displayName,
        handle: Value(handle),
        avatarUrl: Value(avatarUrl),
      ));
    }
  }

  /// Get the next viewer that has a handle but no resolved username.
  Future<Viewer?> getNextViewerWithoutUsername() {
    return (select(viewers)
          ..where((t) =>
              t.handle.isNotNull() &
              t.handle.equals('').not() &
              t.username.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.lastSeen)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Update the resolved username for a viewer.
  Future<void> updateUsername(String channelId, String username) {
    return (update(viewers)..where((t) => t.channelId.equals(channelId)))
        .write(ViewersCompanion(username: Value(username)));
  }

  Future<void> upsertViewersBatch(List<ViewerUpsertEntry> entries) async {
    if (entries.isEmpty) return;

    final channelIds = entries.map((entry) => entry.channelId).toSet().toList();
    final existingRows = await (select(viewers)
          ..where((t) => t.channelId.isIn(channelIds)))
        .get();
    final existingById = {
      for (final viewer in existingRows) viewer.channelId: viewer,
    };
    final now = DateTime.now();

    final companions = entries.map((entry) {
      final existing = existingById[entry.channelId];
      if (existing == null) {
        return ViewersCompanion.insert(
          channelId: entry.channelId,
          displayName: entry.displayName,
          handle: Value(entry.handle),
          avatarUrl: Value(entry.avatarUrl),
          firstSeen: Value(now),
          lastSeen: Value(now),
        );
      }

      final history = (jsonDecode(existing.nameHistory) as List).cast<String>();
      if (existing.displayName != entry.displayName &&
          existing.displayName.isNotEmpty &&
          !history.contains(existing.displayName)) {
        history.add(existing.displayName);
      }

      return ViewersCompanion(
        channelId: Value(entry.channelId),
        displayName: Value(entry.displayName),
        handle: Value(entry.handle),
        username: Value(existing.username),
        avatarUrl: Value(entry.avatarUrl),
        note: Value(existing.note),
        nameHistory: Value(jsonEncode(history)),
        firstSeen: Value(existing.firstSeen),
        lastSeen: Value(now),
      );
    }).toList();

    await batch((b) {
      b.insertAllOnConflictUpdate(viewers, companions);
    });
  }

  Future<void> updateNote(String channelId, String note) {
    return (update(viewers)..where((t) => t.channelId.equals(channelId)))
        .write(ViewersCompanion(note: Value(note)));
  }

  /// Delete a single viewer and all related messages/super chats.
  Future<void> deleteViewer(String channelId) async {
    await (delete(chatMessages)..where((t) => t.channelId.equals(channelId)))
        .go();
    await customStatement(
      'DELETE FROM super_chats WHERE channel_id = ?',
      [channelId],
    );
    await (delete(viewers)..where((t) => t.channelId.equals(channelId))).go();
  }

  /// Delete all viewers and all related messages/super chats.
  Future<void> deleteAllViewers() async {
    await delete(chatMessages).go();
    await customStatement('DELETE FROM super_chats');
    await delete(viewers).go();
  }

  /// Watch all viewers in a liveChatId as a map for efficient lookup.
  Stream<Map<String, Viewer>> watchChatViewers(String liveChatId) {
    return customSelect(
      'SELECT v.* FROM viewers v WHERE v.channel_id IN '
      '(SELECT DISTINCT channel_id FROM chat_messages WHERE live_chat_id = ?)',
      variables: [Variable.withString(liveChatId)],
      readsFrom: {viewers, chatMessages},
    ).watch().map((rows) {
      final map = <String, Viewer>{};
      for (final row in rows) {
        final viewer = viewers.map(row.data);
        map[viewer.channelId] = viewer;
      }
      return map;
    });
  }

  Stream<List<Viewer>> searchViewers(String query) {
    return (select(viewers)
          ..where((t) =>
              t.displayName.like('%$query%') |
              t.handle.like('%$query%') |
              t.username.like('%$query%') |
              t.note.like('%$query%')))
        .watch();
  }

  Stream<List<Viewer>> watchViewersByOwnerChannel(
    String ownerChannelId, {
    String query = '',
    int limit = 200,
  }) {
    final filters = <String>[
      "v.channel_id IN (SELECT DISTINCT cm.channel_id FROM chat_messages cm WHERE cm.live_chat_id IN (SELECT DISTINCT ls.live_chat_id FROM live_streams ls WHERE ls.owner_channel_id = ?))"
    ];
    final variables = <Variable<Object>>[Variable.withString(ownerChannelId)];

    if (query.isNotEmpty) {
      filters.add(
          '(v.display_name LIKE ? OR COALESCE(v.handle, \'\') LIKE ? OR COALESCE(v.username, \'\') LIKE ? OR v.note LIKE ?)');
      final like = '%$query%';
      variables.addAll([
        Variable.withString(like),
        Variable.withString(like),
        Variable.withString(like),
        Variable.withString(like),
      ]);
    }

    final sql = '''
      SELECT v.*
      FROM viewers v
      WHERE ${filters.join(' AND ')}
      ORDER BY v.last_seen DESC
      LIMIT $limit
    ''';

    final queryResult = customSelect(
      sql,
      variables: variables,
      readsFrom: {viewers, chatMessages, liveStreams},
    );

    return queryResult.watch().map(
          (rows) => rows.map((row) => viewers.map(row.data)).toList(),
        );
  }
}

@DriftAccessor(tables: [ChatMessages, Viewers, LiveStreams])
class ChatMessageDao extends DatabaseAccessor<AppDatabase>
    with _$ChatMessageDaoMixin {
  ChatMessageDao(super.db);

  Future<void> insertMessage(ChatMessagesCompanion entry) {
    return into(chatMessages).insertOnConflictUpdate(entry);
  }

  Future<void> insertMessages(List<ChatMessagesCompanion> entries) {
    return batch((b) {
      b.insertAllOnConflictUpdate(chatMessages, entries);
    });
  }

  Stream<List<ChatMessage>> watchMessages(String liveChatId,
      {int limit = 200}) {
    return (select(chatMessages)
          ..where((t) => t.liveChatId.equals(liveChatId))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
          ..limit(limit))
        .watch();
  }

  Future<int> messageCount(String liveChatId) async {
    final count = countAll();
    final query = selectOnly(chatMessages)
      ..addColumns([count])
      ..where(chatMessages.liveChatId.equals(liveChatId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Get all messages for a live chat (for export/history)
  Future<List<ChatMessage>> allMessages(String liveChatId) {
    return (select(chatMessages)
          ..where((t) => t.liveChatId.equals(liveChatId))
          ..orderBy([(t) => OrderingTerm.asc(t.publishedAt)]))
        .get();
  }

  /// Returns the set of channelIds that appear in this liveChatId but have
  /// never appeared in any other live chat — i.e. genuine first-time viewers.
  Stream<Set<String>> watchFirstTimeViewers(String liveChatId) {
    final query = customSelect(
      'SELECT DISTINCT channel_id FROM chat_messages WHERE live_chat_id = ? '
      'AND channel_id NOT IN ('
      '  SELECT DISTINCT channel_id FROM chat_messages WHERE live_chat_id != ?'
      ')',
      variables: [
        Variable.withString(liveChatId),
        Variable.withString(liveChatId),
      ],
      readsFrom: {chatMessages},
    );
    return query.watch().map(
          (rows) => rows.map((r) => r.read<String>('channel_id')).toSet(),
        );
  }

  /// Watch all messages for a specific viewer.
  Stream<List<ChatMessage>> watchViewerMessages(
    String channelId, {
    String ownerChannelId = '',
    int limit = 100,
  }) {
    final query = select(chatMessages)
      ..where((t) => t.channelId.equals(channelId));

    if (ownerChannelId.isNotEmpty) {
      query.where(
        (t) => t.liveChatId.isInQuery(
          selectOnly(liveStreams)
            ..addColumns([liveStreams.liveChatId])
            ..where(liveStreams.ownerChannelId.equals(ownerChannelId)),
        ),
      );
    }

    query
      ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
      ..limit(limit);

    return query.watch();
  }

  /// Stream the total message count for a liveChatId (no row limit).
  Stream<int> watchMessageCount(String liveChatId) {
    final count = countAll();
    final query = selectOnly(chatMessages)
      ..addColumns([count])
      ..where(chatMessages.liveChatId.equals(liveChatId));
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  /// Stream the number of unique viewers for a liveChatId.
  Stream<int> watchUniqueViewerCount(String liveChatId) {
    return customSelect(
      'SELECT COUNT(DISTINCT channel_id) AS cnt FROM chat_messages WHERE live_chat_id = ?',
      variables: [Variable.withString(liveChatId)],
      readsFrom: {chatMessages},
    ).watchSingle().map((row) => row.read<int>('cnt'));
  }
}

@DriftAccessor(tables: [SuperChats, Viewers, LiveStreams])
class SuperChatDao extends DatabaseAccessor<AppDatabase>
    with _$SuperChatDaoMixin {
  SuperChatDao(super.db);

  Future<void> insertSuperChat(SuperChatsCompanion entry) {
    return into(superChats).insertOnConflictUpdate(entry);
  }

  Future<void> insertSuperChats(List<SuperChatsCompanion> entries) {
    if (entries.isEmpty) {
      return Future.value();
    }

    return batch((b) {
      b.insertAllOnConflictUpdate(superChats, entries);
    });
  }

  Stream<List<SuperChat>> watchSuperChats(String liveChatId) {
    return (select(superChats)
          ..where((t) => t.liveChatId.equals(liveChatId))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  }

  /// Watch super chats for a specific viewer.
  Stream<List<SuperChat>> watchViewerSuperChats(
    String channelId, {
    String ownerChannelId = '',
  }) {
    final query = select(superChats)
      ..where((t) => t.channelId.equals(channelId));

    if (ownerChannelId.isNotEmpty) {
      query.where(
        (t) => t.liveChatId.isInQuery(
          selectOnly(liveStreams)
            ..addColumns([liveStreams.liveChatId])
            ..where(liveStreams.ownerChannelId.equals(ownerChannelId)),
        ),
      );
    }

    query.orderBy([(t) => OrderingTerm.desc(t.publishedAt)]);

    return query.watch();
  }

  Future<void> updateStatus(String id, String status) {
    return (update(superChats)..where((t) => t.id.equals(id)))
        .write(SuperChatsCompanion(status: Value(status)));
  }

  /// Total Super Chat amount in micros for a live chat
  Future<int> totalAmountMicros(String liveChatId) async {
    final sum = superChats.amountMicros.sum();
    final query = selectOnly(superChats)
      ..addColumns([sum])
      ..where(superChats.liveChatId.equals(liveChatId));
    final result = await query.getSingle();
    return result.read(sum) ?? 0;
  }

  /// Stream the count of super chats for a liveChatId.
  Stream<int> watchSuperChatCount(String liveChatId) {
    final count = countAll();
    final query = selectOnly(superChats)
      ..addColumns([count])
      ..where(superChats.liveChatId.equals(liveChatId));
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  /// Stream the total amount in micros for a liveChatId.
  Stream<int> watchTotalAmountMicros(String liveChatId) {
    final sum = superChats.amountMicros.sum();
    final query = selectOnly(superChats)
      ..addColumns([sum])
      ..where(superChats.liveChatId.equals(liveChatId));
    return query.watchSingle().map((row) => row.read(sum) ?? 0);
  }

  /// Top donors for a live chat
  Future<List<TopDonorResult>> topDonors(String liveChatId,
      {int limit = 10}) async {
    final sum = superChats.amountMicros.sum();
    final query = selectOnly(superChats)
      ..addColumns([superChats.channelId, superChats.displayName, sum])
      ..where(superChats.liveChatId.equals(liveChatId))
      ..groupBy([superChats.channelId, superChats.displayName])
      ..orderBy([OrderingTerm.desc(sum)])
      ..limit(limit);

    final results = await query.get();
    return results.map((row) {
      return TopDonorResult(
        channelId: row.read(superChats.channelId)!,
        displayName: row.read(superChats.displayName)!,
        totalMicros: row.read(sum) ?? 0,
      );
    }).toList();
  }
}

class TopDonorResult {
  final String channelId;
  final String displayName;
  final int totalMicros;

  TopDonorResult({
    required this.channelId,
    required this.displayName,
    required this.totalMicros,
  });

  double get totalAmount => totalMicros / 1000000.0;
}

class OwnerChannelSummary {
  final String ownerChannelId;
  final String ownerChannelName;

  const OwnerChannelSummary({
    required this.ownerChannelId,
    required this.ownerChannelName,
  });
}

@DriftAccessor(tables: [LiveStreams, ChatMessages, SuperChats, Memberships, Viewers])
class LiveStreamDao extends DatabaseAccessor<AppDatabase>
    with _$LiveStreamDaoMixin {
  LiveStreamDao(super.db);

  Future<void> insertStream(LiveStreamsCompanion entry) {
    return into(liveStreams).insert(entry);
  }

  Future<List<LiveStream>> recentStreams({int limit = 20}) {
    return (select(liveStreams)
          ..orderBy([(t) => OrderingTerm.desc(t.connectedAt)])
          ..limit(limit))
        .get();
  }

  Future<List<OwnerChannelSummary>> distinctOwnerChannels() async {
    final rows = await customSelect(
      'SELECT MAX(id) AS latest_id, owner_channel_id, owner_channel_name '
      'FROM live_streams '
      "WHERE owner_channel_id != '' "
      'GROUP BY owner_channel_id, owner_channel_name '
      'ORDER BY latest_id DESC',
      readsFrom: {liveStreams},
    ).get();

    return rows
        .map(
          (row) => OwnerChannelSummary(
            ownerChannelId: row.read<String>('owner_channel_id'),
            ownerChannelName: row.read<String>('owner_channel_name'),
          ),
        )
        .toList();
  }

  Future<LiveStream?> getStreamByLiveChatId(String liveChatId) {
    return (select(liveStreams)
          ..where((t) => t.liveChatId.equals(liveChatId))
          ..orderBy([(t) => OrderingTerm.desc(t.connectedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> clearHistory() {
    return delete(liveStreams).go();
  }

  /// Watch owner channels where a specific viewer has left messages.
  Stream<List<OwnerChannelSummary>> watchOwnerChannelsByViewer(
      String viewerChannelId) {
    return customSelect(
      'SELECT MAX(ls.id) AS latest_id, ls.owner_channel_id, ls.owner_channel_name '
      'FROM live_streams ls '
      "WHERE ls.owner_channel_id != '' "
      'AND ls.live_chat_id IN ('
      '  SELECT DISTINCT cm.live_chat_id FROM chat_messages cm WHERE cm.channel_id = ?'
      ') '
      'GROUP BY ls.owner_channel_id, ls.owner_channel_name '
      'ORDER BY latest_id DESC',
      variables: [Variable.withString(viewerChannelId)],
      readsFrom: {liveStreams, chatMessages},
    ).watch().map((rows) => rows
        .map(
          (row) => OwnerChannelSummary(
            ownerChannelId: row.read<String>('owner_channel_id'),
            ownerChannelName: row.read<String>('owner_channel_name'),
          ),
        )
        .toList());
  }

  /// Stream-based version of distinctOwnerChannels for reactive UI.
  Stream<List<OwnerChannelSummary>> watchDistinctOwnerChannels() {
    return customSelect(
      'SELECT MAX(id) AS latest_id, owner_channel_id, owner_channel_name '
      'FROM live_streams '
      "WHERE owner_channel_id != '' "
      'GROUP BY owner_channel_id, owner_channel_name '
      'ORDER BY latest_id DESC',
      readsFrom: {liveStreams},
    ).watch().map((rows) => rows
        .map(
          (row) => OwnerChannelSummary(
            ownerChannelId: row.read<String>('owner_channel_id'),
            ownerChannelName: row.read<String>('owner_channel_name'),
          ),
        )
        .toList());
  }

  /// Delete all data related to an owner channel.
  Future<void> deleteByOwnerChannel(String ownerChannelId) async {
    // Find all liveChatIds for this owner channel
    final streams = await (select(liveStreams)
          ..where((t) => t.ownerChannelId.equals(ownerChannelId)))
        .get();
    final liveChatIds = streams
        .map((s) => s.liveChatId)
        .whereType<String>()
        .toSet()
        .toList();

    if (liveChatIds.isNotEmpty) {
      // Delete chat messages
      await (delete(chatMessages)
            ..where((t) => t.liveChatId.isIn(liveChatIds)))
          .go();
      // Delete super chats
      await (delete(superChats)
            ..where((t) => t.liveChatId.isIn(liveChatIds)))
          .go();
      // Delete memberships
      await (delete(memberships)
            ..where((t) => t.liveChatId.isIn(liveChatIds)))
          .go();
    }

    // Delete live stream entries
    await (delete(liveStreams)
          ..where((t) => t.ownerChannelId.equals(ownerChannelId)))
        .go();

    // Clean up orphan viewers (no messages left)
    await customStatement(
      'DELETE FROM viewers WHERE channel_id NOT IN '
      '(SELECT DISTINCT channel_id FROM chat_messages)',
    );
  }

  /// Delete all stream data (messages, super chats, memberships, streams, viewers).
  Future<void> deleteAllData() async {
    await delete(chatMessages).go();
    await delete(superChats).go();
    await customStatement('DELETE FROM memberships');
    await delete(liveStreams).go();
    await delete(viewers).go();
  }
}

@DriftAccessor(tables: [Memberships, LiveStreams])
class MembershipDao extends DatabaseAccessor<AppDatabase>
    with _$MembershipDaoMixin {
  MembershipDao(super.db);

  Future<void> insertMembership(MembershipsCompanion entry) {
    return into(memberships).insertOnConflictUpdate(entry);
  }

  Future<void> insertMemberships(List<MembershipsCompanion> entries) {
    if (entries.isEmpty) return Future.value();
    return batch((b) {
      b.insertAllOnConflictUpdate(memberships, entries);
    });
  }

  Stream<List<Membership>> watchMemberships(String liveChatId) {
    return (select(memberships)
          ..where((t) => t.liveChatId.equals(liveChatId))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  }

  Stream<List<Membership>> watchMembershipsByType(
      String liveChatId, String type) {
    return (select(memberships)
          ..where(
              (t) => t.liveChatId.equals(liveChatId) & t.type.equals(type))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  }

  Stream<int> watchMembershipCount(String liveChatId) {
    final count = countAll();
    final query = selectOnly(memberships)
      ..addColumns([count])
      ..where(memberships.liveChatId.equals(liveChatId));
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  Stream<int> watchNewMemberCount(String liveChatId) {
    final count = countAll();
    final query = selectOnly(memberships)
      ..addColumns([count])
      ..where(memberships.liveChatId.equals(liveChatId) &
          memberships.type.equals('newSponsorEvent'));
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  Stream<int> watchGiftCount(String liveChatId) {
    final sum = memberships.giftCount.sum();
    final query = selectOnly(memberships)
      ..addColumns([sum])
      ..where(memberships.liveChatId.equals(liveChatId) &
          memberships.type.equals('membershipGiftingEvent'));
    return query.watchSingle().map((row) => row.read(sum) ?? 0);
  }

  Stream<int> watchMilestoneCount(String liveChatId) {
    final count = countAll();
    final query = selectOnly(memberships)
      ..addColumns([count])
      ..where(memberships.liveChatId.equals(liveChatId) &
          memberships.type.equals('memberMilestoneChatEvent'));
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  /// Watch memberships for a specific viewer.
  Stream<List<Membership>> watchViewerMemberships(
    String channelId, {
    String ownerChannelId = '',
  }) {
    final query = select(memberships)
      ..where((t) => t.channelId.equals(channelId));

    if (ownerChannelId.isNotEmpty) {
      query.where(
        (t) => t.liveChatId.isInQuery(
          selectOnly(liveStreams)
            ..addColumns([liveStreams.liveChatId])
            ..where(liveStreams.ownerChannelId.equals(ownerChannelId)),
        ),
      );
    }

    query.orderBy([(t) => OrderingTerm.desc(t.publishedAt)]);
    return query.watch();
  }
}
