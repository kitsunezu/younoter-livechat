import 'package:drift/drift.dart';

/// 觀眾資料表 — 以 channelId 為唯一鍵
class Viewers extends Table {
  TextColumn get channelId => text()();
  TextColumn get displayName => text()();
  TextColumn get handle => text().nullable()();
  /// Real username resolved by visiting the channel page.
  TextColumn get username => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
  /// JSON array of previous display names
  TextColumn get nameHistory => text().withDefault(const Constant('[]'))();
  DateTimeColumn get firstSeen => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSeen => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {channelId};
}

/// 聊天訊息表
class ChatMessages extends Table {
  TextColumn get id => text()();
  TextColumn get liveChatId => text()();
  TextColumn get channelId => text().references(Viewers, #channelId)();
  TextColumn get displayName => text()();
  TextColumn get messageText => text()();
  TextColumn get type => text().withDefault(const Constant('textMessage'))();
  BoolColumn get isMember => boolean().withDefault(const Constant(false))();
  DateTimeColumn get publishedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Super Chat / Super Sticker 表
class SuperChats extends Table {
  TextColumn get id => text()();
  TextColumn get liveChatId => text()();
  TextColumn get channelId => text().references(Viewers, #channelId)();
  TextColumn get displayName => text()();
  TextColumn get messageText => text().withDefault(const Constant(''))();
  IntColumn get amountMicros => integer()();
  TextColumn get currency => text()();
  TextColumn get tier => text().withDefault(const Constant(''))();
  TextColumn get type => text().withDefault(const Constant('superChat'))();
  /// Status: unread, read, processed
  TextColumn get status => text().withDefault(const Constant('unread'))();
  DateTimeColumn get publishedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 直播 URL 歷史記錄表
class LiveStreams extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get videoId => text()();
  TextColumn get liveChatId => text().nullable()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get ownerChannelId => text().withDefault(const Constant(''))();
  TextColumn get ownerChannelName => text().withDefault(const Constant(''))();
  TextColumn get url => text()();
  DateTimeColumn get connectedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 會員事件表 — 新加入、贈送會員、里程碑
class Memberships extends Table {
  TextColumn get id => text()();
  TextColumn get liveChatId => text()();
  TextColumn get channelId => text().references(Viewers, #channelId)();
  TextColumn get displayName => text()();
  /// newSponsorEvent, membershipGiftingEvent, memberMilestoneChatEvent
  TextColumn get type => text()();
  TextColumn get messageText => text().withDefault(const Constant(''))();
  /// For milestones: total months of membership
  IntColumn get milestoneMonths => integer().withDefault(const Constant(0))();
  /// For gifting: number of memberships gifted
  IntColumn get giftCount => integer().withDefault(const Constant(0))();
  /// Membership tier / level name
  TextColumn get membershipLevel => text().withDefault(const Constant(''))();
  DateTimeColumn get publishedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
