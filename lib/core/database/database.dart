import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';
import 'daos.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Viewers, ChatMessages, SuperChats, LiveStreams, Memberships],
  daos: [ViewerDao, ChatMessageDao, SuperChatDao, LiveStreamDao, MembershipDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static AppDatabase? _instance;
  static AppDatabase get instance => _instance ??= AppDatabase._();

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(liveStreams, liveStreams.ownerChannelId);
          await m.addColumn(liveStreams, liveStreams.ownerChannelName);
        }
        if (from < 3) {
          await m.addColumn(chatMessages, chatMessages.isMember);
        }
        if (from < 4) {
          await m.createTable(memberships);
        }
        if (from < 5) {
          await m.addColumn(memberships, memberships.membershipLevel);
        }
        if (from < 6) {
          await m.addColumn(viewers, viewers.username);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'younoter', 'younoter.db'));
    await file.parent.create(recursive: true);
    return NativeDatabase.createInBackground(file);
  });
}
