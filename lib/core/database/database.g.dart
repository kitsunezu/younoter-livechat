// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ViewersTable extends Viewers with TableInfo<$ViewersTable, Viewer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViewersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _channelIdMeta =
      const VerificationMeta('channelId');
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
      'channel_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _handleMeta = const VerificationMeta('handle');
  @override
  late final GeneratedColumn<String> handle = GeneratedColumn<String>(
      'handle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _nameHistoryMeta =
      const VerificationMeta('nameHistory');
  @override
  late final GeneratedColumn<String> nameHistory = GeneratedColumn<String>(
      'name_history', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _firstSeenMeta =
      const VerificationMeta('firstSeen');
  @override
  late final GeneratedColumn<DateTime> firstSeen = GeneratedColumn<DateTime>(
      'first_seen', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastSeenMeta =
      const VerificationMeta('lastSeen');
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
      'last_seen', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        channelId,
        displayName,
        handle,
        username,
        avatarUrl,
        note,
        nameHistory,
        firstSeen,
        lastSeen
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'viewers';
  @override
  VerificationContext validateIntegrity(Insertable<Viewer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('channel_id')) {
      context.handle(_channelIdMeta,
          channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta));
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('handle')) {
      context.handle(_handleMeta,
          handle.isAcceptableOrUnknown(data['handle']!, _handleMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('name_history')) {
      context.handle(
          _nameHistoryMeta,
          nameHistory.isAcceptableOrUnknown(
              data['name_history']!, _nameHistoryMeta));
    }
    if (data.containsKey('first_seen')) {
      context.handle(_firstSeenMeta,
          firstSeen.isAcceptableOrUnknown(data['first_seen']!, _firstSeenMeta));
    }
    if (data.containsKey('last_seen')) {
      context.handle(_lastSeenMeta,
          lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {channelId};
  @override
  Viewer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Viewer(
      channelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      handle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}handle']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      nameHistory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_history'])!,
      firstSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}first_seen'])!,
      lastSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_seen'])!,
    );
  }

  @override
  $ViewersTable createAlias(String alias) {
    return $ViewersTable(attachedDatabase, alias);
  }
}

class Viewer extends DataClass implements Insertable<Viewer> {
  final String channelId;
  final String displayName;
  final String? handle;

  /// Real username resolved by visiting the channel page.
  final String? username;
  final String? avatarUrl;
  final String note;

  /// JSON array of previous display names
  final String nameHistory;
  final DateTime firstSeen;
  final DateTime lastSeen;
  const Viewer(
      {required this.channelId,
      required this.displayName,
      this.handle,
      this.username,
      this.avatarUrl,
      required this.note,
      required this.nameHistory,
      required this.firstSeen,
      required this.lastSeen});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['channel_id'] = Variable<String>(channelId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || handle != null) {
      map['handle'] = Variable<String>(handle);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['note'] = Variable<String>(note);
    map['name_history'] = Variable<String>(nameHistory);
    map['first_seen'] = Variable<DateTime>(firstSeen);
    map['last_seen'] = Variable<DateTime>(lastSeen);
    return map;
  }

  ViewersCompanion toCompanion(bool nullToAbsent) {
    return ViewersCompanion(
      channelId: Value(channelId),
      displayName: Value(displayName),
      handle:
          handle == null && nullToAbsent ? const Value.absent() : Value(handle),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      note: Value(note),
      nameHistory: Value(nameHistory),
      firstSeen: Value(firstSeen),
      lastSeen: Value(lastSeen),
    );
  }

  factory Viewer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Viewer(
      channelId: serializer.fromJson<String>(json['channelId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      handle: serializer.fromJson<String?>(json['handle']),
      username: serializer.fromJson<String?>(json['username']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      note: serializer.fromJson<String>(json['note']),
      nameHistory: serializer.fromJson<String>(json['nameHistory']),
      firstSeen: serializer.fromJson<DateTime>(json['firstSeen']),
      lastSeen: serializer.fromJson<DateTime>(json['lastSeen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'channelId': serializer.toJson<String>(channelId),
      'displayName': serializer.toJson<String>(displayName),
      'handle': serializer.toJson<String?>(handle),
      'username': serializer.toJson<String?>(username),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'note': serializer.toJson<String>(note),
      'nameHistory': serializer.toJson<String>(nameHistory),
      'firstSeen': serializer.toJson<DateTime>(firstSeen),
      'lastSeen': serializer.toJson<DateTime>(lastSeen),
    };
  }

  Viewer copyWith(
          {String? channelId,
          String? displayName,
          Value<String?> handle = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> avatarUrl = const Value.absent(),
          String? note,
          String? nameHistory,
          DateTime? firstSeen,
          DateTime? lastSeen}) =>
      Viewer(
        channelId: channelId ?? this.channelId,
        displayName: displayName ?? this.displayName,
        handle: handle.present ? handle.value : this.handle,
        username: username.present ? username.value : this.username,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        note: note ?? this.note,
        nameHistory: nameHistory ?? this.nameHistory,
        firstSeen: firstSeen ?? this.firstSeen,
        lastSeen: lastSeen ?? this.lastSeen,
      );
  Viewer copyWithCompanion(ViewersCompanion data) {
    return Viewer(
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      handle: data.handle.present ? data.handle.value : this.handle,
      username: data.username.present ? data.username.value : this.username,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      note: data.note.present ? data.note.value : this.note,
      nameHistory:
          data.nameHistory.present ? data.nameHistory.value : this.nameHistory,
      firstSeen: data.firstSeen.present ? data.firstSeen.value : this.firstSeen,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Viewer(')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('handle: $handle, ')
          ..write('username: $username, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('note: $note, ')
          ..write('nameHistory: $nameHistory, ')
          ..write('firstSeen: $firstSeen, ')
          ..write('lastSeen: $lastSeen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(channelId, displayName, handle, username,
      avatarUrl, note, nameHistory, firstSeen, lastSeen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Viewer &&
          other.channelId == this.channelId &&
          other.displayName == this.displayName &&
          other.handle == this.handle &&
          other.username == this.username &&
          other.avatarUrl == this.avatarUrl &&
          other.note == this.note &&
          other.nameHistory == this.nameHistory &&
          other.firstSeen == this.firstSeen &&
          other.lastSeen == this.lastSeen);
}

class ViewersCompanion extends UpdateCompanion<Viewer> {
  final Value<String> channelId;
  final Value<String> displayName;
  final Value<String?> handle;
  final Value<String?> username;
  final Value<String?> avatarUrl;
  final Value<String> note;
  final Value<String> nameHistory;
  final Value<DateTime> firstSeen;
  final Value<DateTime> lastSeen;
  final Value<int> rowid;
  const ViewersCompanion({
    this.channelId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.handle = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.note = const Value.absent(),
    this.nameHistory = const Value.absent(),
    this.firstSeen = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ViewersCompanion.insert({
    required String channelId,
    required String displayName,
    this.handle = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.note = const Value.absent(),
    this.nameHistory = const Value.absent(),
    this.firstSeen = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : channelId = Value(channelId),
        displayName = Value(displayName);
  static Insertable<Viewer> custom({
    Expression<String>? channelId,
    Expression<String>? displayName,
    Expression<String>? handle,
    Expression<String>? username,
    Expression<String>? avatarUrl,
    Expression<String>? note,
    Expression<String>? nameHistory,
    Expression<DateTime>? firstSeen,
    Expression<DateTime>? lastSeen,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (channelId != null) 'channel_id': channelId,
      if (displayName != null) 'display_name': displayName,
      if (handle != null) 'handle': handle,
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (note != null) 'note': note,
      if (nameHistory != null) 'name_history': nameHistory,
      if (firstSeen != null) 'first_seen': firstSeen,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ViewersCompanion copyWith(
      {Value<String>? channelId,
      Value<String>? displayName,
      Value<String?>? handle,
      Value<String?>? username,
      Value<String?>? avatarUrl,
      Value<String>? note,
      Value<String>? nameHistory,
      Value<DateTime>? firstSeen,
      Value<DateTime>? lastSeen,
      Value<int>? rowid}) {
    return ViewersCompanion(
      channelId: channelId ?? this.channelId,
      displayName: displayName ?? this.displayName,
      handle: handle ?? this.handle,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      note: note ?? this.note,
      nameHistory: nameHistory ?? this.nameHistory,
      firstSeen: firstSeen ?? this.firstSeen,
      lastSeen: lastSeen ?? this.lastSeen,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (handle.present) {
      map['handle'] = Variable<String>(handle.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (nameHistory.present) {
      map['name_history'] = Variable<String>(nameHistory.value);
    }
    if (firstSeen.present) {
      map['first_seen'] = Variable<DateTime>(firstSeen.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewersCompanion(')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('handle: $handle, ')
          ..write('username: $username, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('note: $note, ')
          ..write('nameHistory: $nameHistory, ')
          ..write('firstSeen: $firstSeen, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _liveChatIdMeta =
      const VerificationMeta('liveChatId');
  @override
  late final GeneratedColumn<String> liveChatId = GeneratedColumn<String>(
      'live_chat_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _channelIdMeta =
      const VerificationMeta('channelId');
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
      'channel_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES viewers (channel_id)'));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageTextMeta =
      const VerificationMeta('messageText');
  @override
  late final GeneratedColumn<String> messageText = GeneratedColumn<String>(
      'message_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('textMessage'));
  static const VerificationMeta _isMemberMeta =
      const VerificationMeta('isMember');
  @override
  late final GeneratedColumn<bool> isMember = GeneratedColumn<bool>(
      'is_member', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_member" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        liveChatId,
        channelId,
        displayName,
        messageText,
        type,
        isMember,
        publishedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('live_chat_id')) {
      context.handle(
          _liveChatIdMeta,
          liveChatId.isAcceptableOrUnknown(
              data['live_chat_id']!, _liveChatIdMeta));
    } else if (isInserting) {
      context.missing(_liveChatIdMeta);
    }
    if (data.containsKey('channel_id')) {
      context.handle(_channelIdMeta,
          channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta));
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('message_text')) {
      context.handle(
          _messageTextMeta,
          messageText.isAcceptableOrUnknown(
              data['message_text']!, _messageTextMeta));
    } else if (isInserting) {
      context.missing(_messageTextMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('is_member')) {
      context.handle(_isMemberMeta,
          isMember.isAcceptableOrUnknown(data['is_member']!, _isMemberMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      liveChatId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}live_chat_id'])!,
      channelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      messageText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_text'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isMember: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_member'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final String id;
  final String liveChatId;
  final String channelId;
  final String displayName;
  final String messageText;
  final String type;
  final bool isMember;
  final DateTime publishedAt;
  final DateTime createdAt;
  const ChatMessage(
      {required this.id,
      required this.liveChatId,
      required this.channelId,
      required this.displayName,
      required this.messageText,
      required this.type,
      required this.isMember,
      required this.publishedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['live_chat_id'] = Variable<String>(liveChatId);
    map['channel_id'] = Variable<String>(channelId);
    map['display_name'] = Variable<String>(displayName);
    map['message_text'] = Variable<String>(messageText);
    map['type'] = Variable<String>(type);
    map['is_member'] = Variable<bool>(isMember);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      liveChatId: Value(liveChatId),
      channelId: Value(channelId),
      displayName: Value(displayName),
      messageText: Value(messageText),
      type: Value(type),
      isMember: Value(isMember),
      publishedAt: Value(publishedAt),
      createdAt: Value(createdAt),
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<String>(json['id']),
      liveChatId: serializer.fromJson<String>(json['liveChatId']),
      channelId: serializer.fromJson<String>(json['channelId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      messageText: serializer.fromJson<String>(json['messageText']),
      type: serializer.fromJson<String>(json['type']),
      isMember: serializer.fromJson<bool>(json['isMember']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'liveChatId': serializer.toJson<String>(liveChatId),
      'channelId': serializer.toJson<String>(channelId),
      'displayName': serializer.toJson<String>(displayName),
      'messageText': serializer.toJson<String>(messageText),
      'type': serializer.toJson<String>(type),
      'isMember': serializer.toJson<bool>(isMember),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChatMessage copyWith(
          {String? id,
          String? liveChatId,
          String? channelId,
          String? displayName,
          String? messageText,
          String? type,
          bool? isMember,
          DateTime? publishedAt,
          DateTime? createdAt}) =>
      ChatMessage(
        id: id ?? this.id,
        liveChatId: liveChatId ?? this.liveChatId,
        channelId: channelId ?? this.channelId,
        displayName: displayName ?? this.displayName,
        messageText: messageText ?? this.messageText,
        type: type ?? this.type,
        isMember: isMember ?? this.isMember,
        publishedAt: publishedAt ?? this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      id: data.id.present ? data.id.value : this.id,
      liveChatId:
          data.liveChatId.present ? data.liveChatId.value : this.liveChatId,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      messageText:
          data.messageText.present ? data.messageText.value : this.messageText,
      type: data.type.present ? data.type.value : this.type,
      isMember: data.isMember.present ? data.isMember.value : this.isMember,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('messageText: $messageText, ')
          ..write('type: $type, ')
          ..write('isMember: $isMember, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, liveChatId, channelId, displayName,
      messageText, type, isMember, publishedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.liveChatId == this.liveChatId &&
          other.channelId == this.channelId &&
          other.displayName == this.displayName &&
          other.messageText == this.messageText &&
          other.type == this.type &&
          other.isMember == this.isMember &&
          other.publishedAt == this.publishedAt &&
          other.createdAt == this.createdAt);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<String> id;
  final Value<String> liveChatId;
  final Value<String> channelId;
  final Value<String> displayName;
  final Value<String> messageText;
  final Value<String> type;
  final Value<bool> isMember;
  final Value<DateTime> publishedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.liveChatId = const Value.absent(),
    this.channelId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.messageText = const Value.absent(),
    this.type = const Value.absent(),
    this.isMember = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    required String id,
    required String liveChatId,
    required String channelId,
    required String displayName,
    required String messageText,
    this.type = const Value.absent(),
    this.isMember = const Value.absent(),
    required DateTime publishedAt,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        liveChatId = Value(liveChatId),
        channelId = Value(channelId),
        displayName = Value(displayName),
        messageText = Value(messageText),
        publishedAt = Value(publishedAt);
  static Insertable<ChatMessage> custom({
    Expression<String>? id,
    Expression<String>? liveChatId,
    Expression<String>? channelId,
    Expression<String>? displayName,
    Expression<String>? messageText,
    Expression<String>? type,
    Expression<bool>? isMember,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (liveChatId != null) 'live_chat_id': liveChatId,
      if (channelId != null) 'channel_id': channelId,
      if (displayName != null) 'display_name': displayName,
      if (messageText != null) 'message_text': messageText,
      if (type != null) 'type': type,
      if (isMember != null) 'is_member': isMember,
      if (publishedAt != null) 'published_at': publishedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? liveChatId,
      Value<String>? channelId,
      Value<String>? displayName,
      Value<String>? messageText,
      Value<String>? type,
      Value<bool>? isMember,
      Value<DateTime>? publishedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      liveChatId: liveChatId ?? this.liveChatId,
      channelId: channelId ?? this.channelId,
      displayName: displayName ?? this.displayName,
      messageText: messageText ?? this.messageText,
      type: type ?? this.type,
      isMember: isMember ?? this.isMember,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (liveChatId.present) {
      map['live_chat_id'] = Variable<String>(liveChatId.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (messageText.present) {
      map['message_text'] = Variable<String>(messageText.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isMember.present) {
      map['is_member'] = Variable<bool>(isMember.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('messageText: $messageText, ')
          ..write('type: $type, ')
          ..write('isMember: $isMember, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuperChatsTable extends SuperChats
    with TableInfo<$SuperChatsTable, SuperChat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuperChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _liveChatIdMeta =
      const VerificationMeta('liveChatId');
  @override
  late final GeneratedColumn<String> liveChatId = GeneratedColumn<String>(
      'live_chat_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _channelIdMeta =
      const VerificationMeta('channelId');
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
      'channel_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES viewers (channel_id)'));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageTextMeta =
      const VerificationMeta('messageText');
  @override
  late final GeneratedColumn<String> messageText = GeneratedColumn<String>(
      'message_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _amountMicrosMeta =
      const VerificationMeta('amountMicros');
  @override
  late final GeneratedColumn<int> amountMicros = GeneratedColumn<int>(
      'amount_micros', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
      'tier', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('superChat'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unread'));
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        liveChatId,
        channelId,
        displayName,
        messageText,
        amountMicros,
        currency,
        tier,
        type,
        status,
        publishedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'super_chats';
  @override
  VerificationContext validateIntegrity(Insertable<SuperChat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('live_chat_id')) {
      context.handle(
          _liveChatIdMeta,
          liveChatId.isAcceptableOrUnknown(
              data['live_chat_id']!, _liveChatIdMeta));
    } else if (isInserting) {
      context.missing(_liveChatIdMeta);
    }
    if (data.containsKey('channel_id')) {
      context.handle(_channelIdMeta,
          channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta));
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('message_text')) {
      context.handle(
          _messageTextMeta,
          messageText.isAcceptableOrUnknown(
              data['message_text']!, _messageTextMeta));
    }
    if (data.containsKey('amount_micros')) {
      context.handle(
          _amountMicrosMeta,
          amountMicros.isAcceptableOrUnknown(
              data['amount_micros']!, _amountMicrosMeta));
    } else if (isInserting) {
      context.missing(_amountMicrosMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
          _tierMeta, tier.isAcceptableOrUnknown(data['tier']!, _tierMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SuperChat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SuperChat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      liveChatId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}live_chat_id'])!,
      channelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      messageText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_text'])!,
      amountMicros: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_micros'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      tier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tier'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SuperChatsTable createAlias(String alias) {
    return $SuperChatsTable(attachedDatabase, alias);
  }
}

class SuperChat extends DataClass implements Insertable<SuperChat> {
  final String id;
  final String liveChatId;
  final String channelId;
  final String displayName;
  final String messageText;
  final int amountMicros;
  final String currency;
  final String tier;
  final String type;

  /// Status: unread, read, processed
  final String status;
  final DateTime publishedAt;
  final DateTime createdAt;
  const SuperChat(
      {required this.id,
      required this.liveChatId,
      required this.channelId,
      required this.displayName,
      required this.messageText,
      required this.amountMicros,
      required this.currency,
      required this.tier,
      required this.type,
      required this.status,
      required this.publishedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['live_chat_id'] = Variable<String>(liveChatId);
    map['channel_id'] = Variable<String>(channelId);
    map['display_name'] = Variable<String>(displayName);
    map['message_text'] = Variable<String>(messageText);
    map['amount_micros'] = Variable<int>(amountMicros);
    map['currency'] = Variable<String>(currency);
    map['tier'] = Variable<String>(tier);
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuperChatsCompanion toCompanion(bool nullToAbsent) {
    return SuperChatsCompanion(
      id: Value(id),
      liveChatId: Value(liveChatId),
      channelId: Value(channelId),
      displayName: Value(displayName),
      messageText: Value(messageText),
      amountMicros: Value(amountMicros),
      currency: Value(currency),
      tier: Value(tier),
      type: Value(type),
      status: Value(status),
      publishedAt: Value(publishedAt),
      createdAt: Value(createdAt),
    );
  }

  factory SuperChat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SuperChat(
      id: serializer.fromJson<String>(json['id']),
      liveChatId: serializer.fromJson<String>(json['liveChatId']),
      channelId: serializer.fromJson<String>(json['channelId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      messageText: serializer.fromJson<String>(json['messageText']),
      amountMicros: serializer.fromJson<int>(json['amountMicros']),
      currency: serializer.fromJson<String>(json['currency']),
      tier: serializer.fromJson<String>(json['tier']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'liveChatId': serializer.toJson<String>(liveChatId),
      'channelId': serializer.toJson<String>(channelId),
      'displayName': serializer.toJson<String>(displayName),
      'messageText': serializer.toJson<String>(messageText),
      'amountMicros': serializer.toJson<int>(amountMicros),
      'currency': serializer.toJson<String>(currency),
      'tier': serializer.toJson<String>(tier),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SuperChat copyWith(
          {String? id,
          String? liveChatId,
          String? channelId,
          String? displayName,
          String? messageText,
          int? amountMicros,
          String? currency,
          String? tier,
          String? type,
          String? status,
          DateTime? publishedAt,
          DateTime? createdAt}) =>
      SuperChat(
        id: id ?? this.id,
        liveChatId: liveChatId ?? this.liveChatId,
        channelId: channelId ?? this.channelId,
        displayName: displayName ?? this.displayName,
        messageText: messageText ?? this.messageText,
        amountMicros: amountMicros ?? this.amountMicros,
        currency: currency ?? this.currency,
        tier: tier ?? this.tier,
        type: type ?? this.type,
        status: status ?? this.status,
        publishedAt: publishedAt ?? this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  SuperChat copyWithCompanion(SuperChatsCompanion data) {
    return SuperChat(
      id: data.id.present ? data.id.value : this.id,
      liveChatId:
          data.liveChatId.present ? data.liveChatId.value : this.liveChatId,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      messageText:
          data.messageText.present ? data.messageText.value : this.messageText,
      amountMicros: data.amountMicros.present
          ? data.amountMicros.value
          : this.amountMicros,
      currency: data.currency.present ? data.currency.value : this.currency,
      tier: data.tier.present ? data.tier.value : this.tier,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SuperChat(')
          ..write('id: $id, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('messageText: $messageText, ')
          ..write('amountMicros: $amountMicros, ')
          ..write('currency: $currency, ')
          ..write('tier: $tier, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      liveChatId,
      channelId,
      displayName,
      messageText,
      amountMicros,
      currency,
      tier,
      type,
      status,
      publishedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SuperChat &&
          other.id == this.id &&
          other.liveChatId == this.liveChatId &&
          other.channelId == this.channelId &&
          other.displayName == this.displayName &&
          other.messageText == this.messageText &&
          other.amountMicros == this.amountMicros &&
          other.currency == this.currency &&
          other.tier == this.tier &&
          other.type == this.type &&
          other.status == this.status &&
          other.publishedAt == this.publishedAt &&
          other.createdAt == this.createdAt);
}

class SuperChatsCompanion extends UpdateCompanion<SuperChat> {
  final Value<String> id;
  final Value<String> liveChatId;
  final Value<String> channelId;
  final Value<String> displayName;
  final Value<String> messageText;
  final Value<int> amountMicros;
  final Value<String> currency;
  final Value<String> tier;
  final Value<String> type;
  final Value<String> status;
  final Value<DateTime> publishedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SuperChatsCompanion({
    this.id = const Value.absent(),
    this.liveChatId = const Value.absent(),
    this.channelId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.messageText = const Value.absent(),
    this.amountMicros = const Value.absent(),
    this.currency = const Value.absent(),
    this.tier = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuperChatsCompanion.insert({
    required String id,
    required String liveChatId,
    required String channelId,
    required String displayName,
    this.messageText = const Value.absent(),
    required int amountMicros,
    required String currency,
    this.tier = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime publishedAt,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        liveChatId = Value(liveChatId),
        channelId = Value(channelId),
        displayName = Value(displayName),
        amountMicros = Value(amountMicros),
        currency = Value(currency),
        publishedAt = Value(publishedAt);
  static Insertable<SuperChat> custom({
    Expression<String>? id,
    Expression<String>? liveChatId,
    Expression<String>? channelId,
    Expression<String>? displayName,
    Expression<String>? messageText,
    Expression<int>? amountMicros,
    Expression<String>? currency,
    Expression<String>? tier,
    Expression<String>? type,
    Expression<String>? status,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (liveChatId != null) 'live_chat_id': liveChatId,
      if (channelId != null) 'channel_id': channelId,
      if (displayName != null) 'display_name': displayName,
      if (messageText != null) 'message_text': messageText,
      if (amountMicros != null) 'amount_micros': amountMicros,
      if (currency != null) 'currency': currency,
      if (tier != null) 'tier': tier,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (publishedAt != null) 'published_at': publishedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuperChatsCompanion copyWith(
      {Value<String>? id,
      Value<String>? liveChatId,
      Value<String>? channelId,
      Value<String>? displayName,
      Value<String>? messageText,
      Value<int>? amountMicros,
      Value<String>? currency,
      Value<String>? tier,
      Value<String>? type,
      Value<String>? status,
      Value<DateTime>? publishedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SuperChatsCompanion(
      id: id ?? this.id,
      liveChatId: liveChatId ?? this.liveChatId,
      channelId: channelId ?? this.channelId,
      displayName: displayName ?? this.displayName,
      messageText: messageText ?? this.messageText,
      amountMicros: amountMicros ?? this.amountMicros,
      currency: currency ?? this.currency,
      tier: tier ?? this.tier,
      type: type ?? this.type,
      status: status ?? this.status,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (liveChatId.present) {
      map['live_chat_id'] = Variable<String>(liveChatId.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (messageText.present) {
      map['message_text'] = Variable<String>(messageText.value);
    }
    if (amountMicros.present) {
      map['amount_micros'] = Variable<int>(amountMicros.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuperChatsCompanion(')
          ..write('id: $id, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('messageText: $messageText, ')
          ..write('amountMicros: $amountMicros, ')
          ..write('currency: $currency, ')
          ..write('tier: $tier, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LiveStreamsTable extends LiveStreams
    with TableInfo<$LiveStreamsTable, LiveStream> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiveStreamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _videoIdMeta =
      const VerificationMeta('videoId');
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
      'video_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _liveChatIdMeta =
      const VerificationMeta('liveChatId');
  @override
  late final GeneratedColumn<String> liveChatId = GeneratedColumn<String>(
      'live_chat_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _ownerChannelIdMeta =
      const VerificationMeta('ownerChannelId');
  @override
  late final GeneratedColumn<String> ownerChannelId = GeneratedColumn<String>(
      'owner_channel_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _ownerChannelNameMeta =
      const VerificationMeta('ownerChannelName');
  @override
  late final GeneratedColumn<String> ownerChannelName = GeneratedColumn<String>(
      'owner_channel_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _connectedAtMeta =
      const VerificationMeta('connectedAt');
  @override
  late final GeneratedColumn<DateTime> connectedAt = GeneratedColumn<DateTime>(
      'connected_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        videoId,
        liveChatId,
        title,
        ownerChannelId,
        ownerChannelName,
        url,
        connectedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'live_streams';
  @override
  VerificationContext validateIntegrity(Insertable<LiveStream> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('live_chat_id')) {
      context.handle(
          _liveChatIdMeta,
          liveChatId.isAcceptableOrUnknown(
              data['live_chat_id']!, _liveChatIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('owner_channel_id')) {
      context.handle(
          _ownerChannelIdMeta,
          ownerChannelId.isAcceptableOrUnknown(
              data['owner_channel_id']!, _ownerChannelIdMeta));
    }
    if (data.containsKey('owner_channel_name')) {
      context.handle(
          _ownerChannelNameMeta,
          ownerChannelName.isAcceptableOrUnknown(
              data['owner_channel_name']!, _ownerChannelNameMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('connected_at')) {
      context.handle(
          _connectedAtMeta,
          connectedAt.isAcceptableOrUnknown(
              data['connected_at']!, _connectedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LiveStream map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiveStream(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      videoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video_id'])!,
      liveChatId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}live_chat_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      ownerChannelId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}owner_channel_id'])!,
      ownerChannelName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}owner_channel_name'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      connectedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}connected_at'])!,
    );
  }

  @override
  $LiveStreamsTable createAlias(String alias) {
    return $LiveStreamsTable(attachedDatabase, alias);
  }
}

class LiveStream extends DataClass implements Insertable<LiveStream> {
  final int id;
  final String videoId;
  final String? liveChatId;
  final String title;
  final String ownerChannelId;
  final String ownerChannelName;
  final String url;
  final DateTime connectedAt;
  const LiveStream(
      {required this.id,
      required this.videoId,
      this.liveChatId,
      required this.title,
      required this.ownerChannelId,
      required this.ownerChannelName,
      required this.url,
      required this.connectedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['video_id'] = Variable<String>(videoId);
    if (!nullToAbsent || liveChatId != null) {
      map['live_chat_id'] = Variable<String>(liveChatId);
    }
    map['title'] = Variable<String>(title);
    map['owner_channel_id'] = Variable<String>(ownerChannelId);
    map['owner_channel_name'] = Variable<String>(ownerChannelName);
    map['url'] = Variable<String>(url);
    map['connected_at'] = Variable<DateTime>(connectedAt);
    return map;
  }

  LiveStreamsCompanion toCompanion(bool nullToAbsent) {
    return LiveStreamsCompanion(
      id: Value(id),
      videoId: Value(videoId),
      liveChatId: liveChatId == null && nullToAbsent
          ? const Value.absent()
          : Value(liveChatId),
      title: Value(title),
      ownerChannelId: Value(ownerChannelId),
      ownerChannelName: Value(ownerChannelName),
      url: Value(url),
      connectedAt: Value(connectedAt),
    );
  }

  factory LiveStream.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiveStream(
      id: serializer.fromJson<int>(json['id']),
      videoId: serializer.fromJson<String>(json['videoId']),
      liveChatId: serializer.fromJson<String?>(json['liveChatId']),
      title: serializer.fromJson<String>(json['title']),
      ownerChannelId: serializer.fromJson<String>(json['ownerChannelId']),
      ownerChannelName: serializer.fromJson<String>(json['ownerChannelName']),
      url: serializer.fromJson<String>(json['url']),
      connectedAt: serializer.fromJson<DateTime>(json['connectedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'videoId': serializer.toJson<String>(videoId),
      'liveChatId': serializer.toJson<String?>(liveChatId),
      'title': serializer.toJson<String>(title),
      'ownerChannelId': serializer.toJson<String>(ownerChannelId),
      'ownerChannelName': serializer.toJson<String>(ownerChannelName),
      'url': serializer.toJson<String>(url),
      'connectedAt': serializer.toJson<DateTime>(connectedAt),
    };
  }

  LiveStream copyWith(
          {int? id,
          String? videoId,
          Value<String?> liveChatId = const Value.absent(),
          String? title,
          String? ownerChannelId,
          String? ownerChannelName,
          String? url,
          DateTime? connectedAt}) =>
      LiveStream(
        id: id ?? this.id,
        videoId: videoId ?? this.videoId,
        liveChatId: liveChatId.present ? liveChatId.value : this.liveChatId,
        title: title ?? this.title,
        ownerChannelId: ownerChannelId ?? this.ownerChannelId,
        ownerChannelName: ownerChannelName ?? this.ownerChannelName,
        url: url ?? this.url,
        connectedAt: connectedAt ?? this.connectedAt,
      );
  LiveStream copyWithCompanion(LiveStreamsCompanion data) {
    return LiveStream(
      id: data.id.present ? data.id.value : this.id,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      liveChatId:
          data.liveChatId.present ? data.liveChatId.value : this.liveChatId,
      title: data.title.present ? data.title.value : this.title,
      ownerChannelId: data.ownerChannelId.present
          ? data.ownerChannelId.value
          : this.ownerChannelId,
      ownerChannelName: data.ownerChannelName.present
          ? data.ownerChannelName.value
          : this.ownerChannelName,
      url: data.url.present ? data.url.value : this.url,
      connectedAt:
          data.connectedAt.present ? data.connectedAt.value : this.connectedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiveStream(')
          ..write('id: $id, ')
          ..write('videoId: $videoId, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('title: $title, ')
          ..write('ownerChannelId: $ownerChannelId, ')
          ..write('ownerChannelName: $ownerChannelName, ')
          ..write('url: $url, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, videoId, liveChatId, title,
      ownerChannelId, ownerChannelName, url, connectedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiveStream &&
          other.id == this.id &&
          other.videoId == this.videoId &&
          other.liveChatId == this.liveChatId &&
          other.title == this.title &&
          other.ownerChannelId == this.ownerChannelId &&
          other.ownerChannelName == this.ownerChannelName &&
          other.url == this.url &&
          other.connectedAt == this.connectedAt);
}

class LiveStreamsCompanion extends UpdateCompanion<LiveStream> {
  final Value<int> id;
  final Value<String> videoId;
  final Value<String?> liveChatId;
  final Value<String> title;
  final Value<String> ownerChannelId;
  final Value<String> ownerChannelName;
  final Value<String> url;
  final Value<DateTime> connectedAt;
  const LiveStreamsCompanion({
    this.id = const Value.absent(),
    this.videoId = const Value.absent(),
    this.liveChatId = const Value.absent(),
    this.title = const Value.absent(),
    this.ownerChannelId = const Value.absent(),
    this.ownerChannelName = const Value.absent(),
    this.url = const Value.absent(),
    this.connectedAt = const Value.absent(),
  });
  LiveStreamsCompanion.insert({
    this.id = const Value.absent(),
    required String videoId,
    this.liveChatId = const Value.absent(),
    this.title = const Value.absent(),
    this.ownerChannelId = const Value.absent(),
    this.ownerChannelName = const Value.absent(),
    required String url,
    this.connectedAt = const Value.absent(),
  })  : videoId = Value(videoId),
        url = Value(url);
  static Insertable<LiveStream> custom({
    Expression<int>? id,
    Expression<String>? videoId,
    Expression<String>? liveChatId,
    Expression<String>? title,
    Expression<String>? ownerChannelId,
    Expression<String>? ownerChannelName,
    Expression<String>? url,
    Expression<DateTime>? connectedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (videoId != null) 'video_id': videoId,
      if (liveChatId != null) 'live_chat_id': liveChatId,
      if (title != null) 'title': title,
      if (ownerChannelId != null) 'owner_channel_id': ownerChannelId,
      if (ownerChannelName != null) 'owner_channel_name': ownerChannelName,
      if (url != null) 'url': url,
      if (connectedAt != null) 'connected_at': connectedAt,
    });
  }

  LiveStreamsCompanion copyWith(
      {Value<int>? id,
      Value<String>? videoId,
      Value<String?>? liveChatId,
      Value<String>? title,
      Value<String>? ownerChannelId,
      Value<String>? ownerChannelName,
      Value<String>? url,
      Value<DateTime>? connectedAt}) {
    return LiveStreamsCompanion(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      liveChatId: liveChatId ?? this.liveChatId,
      title: title ?? this.title,
      ownerChannelId: ownerChannelId ?? this.ownerChannelId,
      ownerChannelName: ownerChannelName ?? this.ownerChannelName,
      url: url ?? this.url,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (liveChatId.present) {
      map['live_chat_id'] = Variable<String>(liveChatId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (ownerChannelId.present) {
      map['owner_channel_id'] = Variable<String>(ownerChannelId.value);
    }
    if (ownerChannelName.present) {
      map['owner_channel_name'] = Variable<String>(ownerChannelName.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (connectedAt.present) {
      map['connected_at'] = Variable<DateTime>(connectedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiveStreamsCompanion(')
          ..write('id: $id, ')
          ..write('videoId: $videoId, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('title: $title, ')
          ..write('ownerChannelId: $ownerChannelId, ')
          ..write('ownerChannelName: $ownerChannelName, ')
          ..write('url: $url, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }
}

class $MembershipsTable extends Memberships
    with TableInfo<$MembershipsTable, Membership> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _liveChatIdMeta =
      const VerificationMeta('liveChatId');
  @override
  late final GeneratedColumn<String> liveChatId = GeneratedColumn<String>(
      'live_chat_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _channelIdMeta =
      const VerificationMeta('channelId');
  @override
  late final GeneratedColumn<String> channelId = GeneratedColumn<String>(
      'channel_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES viewers (channel_id)'));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageTextMeta =
      const VerificationMeta('messageText');
  @override
  late final GeneratedColumn<String> messageText = GeneratedColumn<String>(
      'message_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _milestoneMonthsMeta =
      const VerificationMeta('milestoneMonths');
  @override
  late final GeneratedColumn<int> milestoneMonths = GeneratedColumn<int>(
      'milestone_months', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _giftCountMeta =
      const VerificationMeta('giftCount');
  @override
  late final GeneratedColumn<int> giftCount = GeneratedColumn<int>(
      'gift_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _membershipLevelMeta =
      const VerificationMeta('membershipLevel');
  @override
  late final GeneratedColumn<String> membershipLevel = GeneratedColumn<String>(
      'membership_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        liveChatId,
        channelId,
        displayName,
        type,
        messageText,
        milestoneMonths,
        giftCount,
        membershipLevel,
        publishedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memberships';
  @override
  VerificationContext validateIntegrity(Insertable<Membership> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('live_chat_id')) {
      context.handle(
          _liveChatIdMeta,
          liveChatId.isAcceptableOrUnknown(
              data['live_chat_id']!, _liveChatIdMeta));
    } else if (isInserting) {
      context.missing(_liveChatIdMeta);
    }
    if (data.containsKey('channel_id')) {
      context.handle(_channelIdMeta,
          channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta));
    } else if (isInserting) {
      context.missing(_channelIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('message_text')) {
      context.handle(
          _messageTextMeta,
          messageText.isAcceptableOrUnknown(
              data['message_text']!, _messageTextMeta));
    }
    if (data.containsKey('milestone_months')) {
      context.handle(
          _milestoneMonthsMeta,
          milestoneMonths.isAcceptableOrUnknown(
              data['milestone_months']!, _milestoneMonthsMeta));
    }
    if (data.containsKey('gift_count')) {
      context.handle(_giftCountMeta,
          giftCount.isAcceptableOrUnknown(data['gift_count']!, _giftCountMeta));
    }
    if (data.containsKey('membership_level')) {
      context.handle(
          _membershipLevelMeta,
          membershipLevel.isAcceptableOrUnknown(
              data['membership_level']!, _membershipLevelMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Membership map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Membership(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      liveChatId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}live_chat_id'])!,
      channelId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      messageText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_text'])!,
      milestoneMonths: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}milestone_months'])!,
      giftCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gift_count'])!,
      membershipLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}membership_level'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MembershipsTable createAlias(String alias) {
    return $MembershipsTable(attachedDatabase, alias);
  }
}

class Membership extends DataClass implements Insertable<Membership> {
  final String id;
  final String liveChatId;
  final String channelId;
  final String displayName;

  /// newSponsorEvent, membershipGiftingEvent, memberMilestoneChatEvent
  final String type;
  final String messageText;

  /// For milestones: total months of membership
  final int milestoneMonths;

  /// For gifting: number of memberships gifted
  final int giftCount;

  /// Membership tier / level name
  final String membershipLevel;
  final DateTime publishedAt;
  final DateTime createdAt;
  const Membership(
      {required this.id,
      required this.liveChatId,
      required this.channelId,
      required this.displayName,
      required this.type,
      required this.messageText,
      required this.milestoneMonths,
      required this.giftCount,
      required this.membershipLevel,
      required this.publishedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['live_chat_id'] = Variable<String>(liveChatId);
    map['channel_id'] = Variable<String>(channelId);
    map['display_name'] = Variable<String>(displayName);
    map['type'] = Variable<String>(type);
    map['message_text'] = Variable<String>(messageText);
    map['milestone_months'] = Variable<int>(milestoneMonths);
    map['gift_count'] = Variable<int>(giftCount);
    map['membership_level'] = Variable<String>(membershipLevel);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MembershipsCompanion toCompanion(bool nullToAbsent) {
    return MembershipsCompanion(
      id: Value(id),
      liveChatId: Value(liveChatId),
      channelId: Value(channelId),
      displayName: Value(displayName),
      type: Value(type),
      messageText: Value(messageText),
      milestoneMonths: Value(milestoneMonths),
      giftCount: Value(giftCount),
      membershipLevel: Value(membershipLevel),
      publishedAt: Value(publishedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Membership.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Membership(
      id: serializer.fromJson<String>(json['id']),
      liveChatId: serializer.fromJson<String>(json['liveChatId']),
      channelId: serializer.fromJson<String>(json['channelId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      type: serializer.fromJson<String>(json['type']),
      messageText: serializer.fromJson<String>(json['messageText']),
      milestoneMonths: serializer.fromJson<int>(json['milestoneMonths']),
      giftCount: serializer.fromJson<int>(json['giftCount']),
      membershipLevel: serializer.fromJson<String>(json['membershipLevel']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'liveChatId': serializer.toJson<String>(liveChatId),
      'channelId': serializer.toJson<String>(channelId),
      'displayName': serializer.toJson<String>(displayName),
      'type': serializer.toJson<String>(type),
      'messageText': serializer.toJson<String>(messageText),
      'milestoneMonths': serializer.toJson<int>(milestoneMonths),
      'giftCount': serializer.toJson<int>(giftCount),
      'membershipLevel': serializer.toJson<String>(membershipLevel),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Membership copyWith(
          {String? id,
          String? liveChatId,
          String? channelId,
          String? displayName,
          String? type,
          String? messageText,
          int? milestoneMonths,
          int? giftCount,
          String? membershipLevel,
          DateTime? publishedAt,
          DateTime? createdAt}) =>
      Membership(
        id: id ?? this.id,
        liveChatId: liveChatId ?? this.liveChatId,
        channelId: channelId ?? this.channelId,
        displayName: displayName ?? this.displayName,
        type: type ?? this.type,
        messageText: messageText ?? this.messageText,
        milestoneMonths: milestoneMonths ?? this.milestoneMonths,
        giftCount: giftCount ?? this.giftCount,
        membershipLevel: membershipLevel ?? this.membershipLevel,
        publishedAt: publishedAt ?? this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  Membership copyWithCompanion(MembershipsCompanion data) {
    return Membership(
      id: data.id.present ? data.id.value : this.id,
      liveChatId:
          data.liveChatId.present ? data.liveChatId.value : this.liveChatId,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      type: data.type.present ? data.type.value : this.type,
      messageText:
          data.messageText.present ? data.messageText.value : this.messageText,
      milestoneMonths: data.milestoneMonths.present
          ? data.milestoneMonths.value
          : this.milestoneMonths,
      giftCount: data.giftCount.present ? data.giftCount.value : this.giftCount,
      membershipLevel: data.membershipLevel.present
          ? data.membershipLevel.value
          : this.membershipLevel,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Membership(')
          ..write('id: $id, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('type: $type, ')
          ..write('messageText: $messageText, ')
          ..write('milestoneMonths: $milestoneMonths, ')
          ..write('giftCount: $giftCount, ')
          ..write('membershipLevel: $membershipLevel, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      liveChatId,
      channelId,
      displayName,
      type,
      messageText,
      milestoneMonths,
      giftCount,
      membershipLevel,
      publishedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Membership &&
          other.id == this.id &&
          other.liveChatId == this.liveChatId &&
          other.channelId == this.channelId &&
          other.displayName == this.displayName &&
          other.type == this.type &&
          other.messageText == this.messageText &&
          other.milestoneMonths == this.milestoneMonths &&
          other.giftCount == this.giftCount &&
          other.membershipLevel == this.membershipLevel &&
          other.publishedAt == this.publishedAt &&
          other.createdAt == this.createdAt);
}

class MembershipsCompanion extends UpdateCompanion<Membership> {
  final Value<String> id;
  final Value<String> liveChatId;
  final Value<String> channelId;
  final Value<String> displayName;
  final Value<String> type;
  final Value<String> messageText;
  final Value<int> milestoneMonths;
  final Value<int> giftCount;
  final Value<String> membershipLevel;
  final Value<DateTime> publishedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MembershipsCompanion({
    this.id = const Value.absent(),
    this.liveChatId = const Value.absent(),
    this.channelId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.type = const Value.absent(),
    this.messageText = const Value.absent(),
    this.milestoneMonths = const Value.absent(),
    this.giftCount = const Value.absent(),
    this.membershipLevel = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipsCompanion.insert({
    required String id,
    required String liveChatId,
    required String channelId,
    required String displayName,
    required String type,
    this.messageText = const Value.absent(),
    this.milestoneMonths = const Value.absent(),
    this.giftCount = const Value.absent(),
    this.membershipLevel = const Value.absent(),
    required DateTime publishedAt,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        liveChatId = Value(liveChatId),
        channelId = Value(channelId),
        displayName = Value(displayName),
        type = Value(type),
        publishedAt = Value(publishedAt);
  static Insertable<Membership> custom({
    Expression<String>? id,
    Expression<String>? liveChatId,
    Expression<String>? channelId,
    Expression<String>? displayName,
    Expression<String>? type,
    Expression<String>? messageText,
    Expression<int>? milestoneMonths,
    Expression<int>? giftCount,
    Expression<String>? membershipLevel,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (liveChatId != null) 'live_chat_id': liveChatId,
      if (channelId != null) 'channel_id': channelId,
      if (displayName != null) 'display_name': displayName,
      if (type != null) 'type': type,
      if (messageText != null) 'message_text': messageText,
      if (milestoneMonths != null) 'milestone_months': milestoneMonths,
      if (giftCount != null) 'gift_count': giftCount,
      if (membershipLevel != null) 'membership_level': membershipLevel,
      if (publishedAt != null) 'published_at': publishedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipsCompanion copyWith(
      {Value<String>? id,
      Value<String>? liveChatId,
      Value<String>? channelId,
      Value<String>? displayName,
      Value<String>? type,
      Value<String>? messageText,
      Value<int>? milestoneMonths,
      Value<int>? giftCount,
      Value<String>? membershipLevel,
      Value<DateTime>? publishedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MembershipsCompanion(
      id: id ?? this.id,
      liveChatId: liveChatId ?? this.liveChatId,
      channelId: channelId ?? this.channelId,
      displayName: displayName ?? this.displayName,
      type: type ?? this.type,
      messageText: messageText ?? this.messageText,
      milestoneMonths: milestoneMonths ?? this.milestoneMonths,
      giftCount: giftCount ?? this.giftCount,
      membershipLevel: membershipLevel ?? this.membershipLevel,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (liveChatId.present) {
      map['live_chat_id'] = Variable<String>(liveChatId.value);
    }
    if (channelId.present) {
      map['channel_id'] = Variable<String>(channelId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (messageText.present) {
      map['message_text'] = Variable<String>(messageText.value);
    }
    if (milestoneMonths.present) {
      map['milestone_months'] = Variable<int>(milestoneMonths.value);
    }
    if (giftCount.present) {
      map['gift_count'] = Variable<int>(giftCount.value);
    }
    if (membershipLevel.present) {
      map['membership_level'] = Variable<String>(membershipLevel.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipsCompanion(')
          ..write('id: $id, ')
          ..write('liveChatId: $liveChatId, ')
          ..write('channelId: $channelId, ')
          ..write('displayName: $displayName, ')
          ..write('type: $type, ')
          ..write('messageText: $messageText, ')
          ..write('milestoneMonths: $milestoneMonths, ')
          ..write('giftCount: $giftCount, ')
          ..write('membershipLevel: $membershipLevel, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ViewersTable viewers = $ViewersTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $SuperChatsTable superChats = $SuperChatsTable(this);
  late final $LiveStreamsTable liveStreams = $LiveStreamsTable(this);
  late final $MembershipsTable memberships = $MembershipsTable(this);
  late final ViewerDao viewerDao = ViewerDao(this as AppDatabase);
  late final ChatMessageDao chatMessageDao =
      ChatMessageDao(this as AppDatabase);
  late final SuperChatDao superChatDao = SuperChatDao(this as AppDatabase);
  late final LiveStreamDao liveStreamDao = LiveStreamDao(this as AppDatabase);
  late final MembershipDao membershipDao = MembershipDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [viewers, chatMessages, superChats, liveStreams, memberships];
}

typedef $$ViewersTableCreateCompanionBuilder = ViewersCompanion Function({
  required String channelId,
  required String displayName,
  Value<String?> handle,
  Value<String?> username,
  Value<String?> avatarUrl,
  Value<String> note,
  Value<String> nameHistory,
  Value<DateTime> firstSeen,
  Value<DateTime> lastSeen,
  Value<int> rowid,
});
typedef $$ViewersTableUpdateCompanionBuilder = ViewersCompanion Function({
  Value<String> channelId,
  Value<String> displayName,
  Value<String?> handle,
  Value<String?> username,
  Value<String?> avatarUrl,
  Value<String> note,
  Value<String> nameHistory,
  Value<DateTime> firstSeen,
  Value<DateTime> lastSeen,
  Value<int> rowid,
});

final class $$ViewersTableReferences
    extends BaseReferences<_$AppDatabase, $ViewersTable, Viewer> {
  $$ViewersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessage>>
      _chatMessagesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.chatMessages,
              aliasName: $_aliasNameGenerator(
                  db.viewers.channelId, db.chatMessages.channelId));

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager($_db, $_db.chatMessages)
        .filter((f) => f.channelId.channelId
            .sqlEquals($_itemColumn<String>('channel_id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SuperChatsTable, List<SuperChat>>
      _superChatsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.superChats,
              aliasName: $_aliasNameGenerator(
                  db.viewers.channelId, db.superChats.channelId));

  $$SuperChatsTableProcessedTableManager get superChatsRefs {
    final manager = $$SuperChatsTableTableManager($_db, $_db.superChats).filter(
        (f) => f.channelId.channelId
            .sqlEquals($_itemColumn<String>('channel_id')!));

    final cache = $_typedResult.readTableOrNull(_superChatsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MembershipsTable, List<Membership>>
      _membershipsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.memberships,
              aliasName: $_aliasNameGenerator(
                  db.viewers.channelId, db.memberships.channelId));

  $$MembershipsTableProcessedTableManager get membershipsRefs {
    final manager = $$MembershipsTableTableManager($_db, $_db.memberships)
        .filter((f) => f.channelId.channelId
            .sqlEquals($_itemColumn<String>('channel_id')!));

    final cache = $_typedResult.readTableOrNull(_membershipsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ViewersTableFilterComposer
    extends Composer<_$AppDatabase, $ViewersTable> {
  $$ViewersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get channelId => $composableBuilder(
      column: $table.channelId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get handle => $composableBuilder(
      column: $table.handle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameHistory => $composableBuilder(
      column: $table.nameHistory, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firstSeen => $composableBuilder(
      column: $table.firstSeen, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnFilters(column));

  Expression<bool> chatMessagesRefs(
      Expression<bool> Function($$ChatMessagesTableFilterComposer f) f) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.chatMessages,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessagesTableFilterComposer(
              $db: $db,
              $table: $db.chatMessages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> superChatsRefs(
      Expression<bool> Function($$SuperChatsTableFilterComposer f) f) {
    final $$SuperChatsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.superChats,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuperChatsTableFilterComposer(
              $db: $db,
              $table: $db.superChats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> membershipsRefs(
      Expression<bool> Function($$MembershipsTableFilterComposer f) f) {
    final $$MembershipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.memberships,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MembershipsTableFilterComposer(
              $db: $db,
              $table: $db.memberships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ViewersTableOrderingComposer
    extends Composer<_$AppDatabase, $ViewersTable> {
  $$ViewersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get channelId => $composableBuilder(
      column: $table.channelId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get handle => $composableBuilder(
      column: $table.handle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameHistory => $composableBuilder(
      column: $table.nameHistory, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstSeen => $composableBuilder(
      column: $table.firstSeen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnOrderings(column));
}

class $$ViewersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViewersTable> {
  $$ViewersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get channelId =>
      $composableBuilder(column: $table.channelId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get handle =>
      $composableBuilder(column: $table.handle, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get nameHistory => $composableBuilder(
      column: $table.nameHistory, builder: (column) => column);

  GeneratedColumn<DateTime> get firstSeen =>
      $composableBuilder(column: $table.firstSeen, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  Expression<T> chatMessagesRefs<T extends Object>(
      Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.chatMessages,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.chatMessages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> superChatsRefs<T extends Object>(
      Expression<T> Function($$SuperChatsTableAnnotationComposer a) f) {
    final $$SuperChatsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.superChats,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SuperChatsTableAnnotationComposer(
              $db: $db,
              $table: $db.superChats,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> membershipsRefs<T extends Object>(
      Expression<T> Function($$MembershipsTableAnnotationComposer a) f) {
    final $$MembershipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.memberships,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MembershipsTableAnnotationComposer(
              $db: $db,
              $table: $db.memberships,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ViewersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ViewersTable,
    Viewer,
    $$ViewersTableFilterComposer,
    $$ViewersTableOrderingComposer,
    $$ViewersTableAnnotationComposer,
    $$ViewersTableCreateCompanionBuilder,
    $$ViewersTableUpdateCompanionBuilder,
    (Viewer, $$ViewersTableReferences),
    Viewer,
    PrefetchHooks Function(
        {bool chatMessagesRefs, bool superChatsRefs, bool membershipsRefs})> {
  $$ViewersTableTableManager(_$AppDatabase db, $ViewersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViewersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViewersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViewersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> channelId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String?> handle = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<String> nameHistory = const Value.absent(),
            Value<DateTime> firstSeen = const Value.absent(),
            Value<DateTime> lastSeen = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ViewersCompanion(
            channelId: channelId,
            displayName: displayName,
            handle: handle,
            username: username,
            avatarUrl: avatarUrl,
            note: note,
            nameHistory: nameHistory,
            firstSeen: firstSeen,
            lastSeen: lastSeen,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String channelId,
            required String displayName,
            Value<String?> handle = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<String> nameHistory = const Value.absent(),
            Value<DateTime> firstSeen = const Value.absent(),
            Value<DateTime> lastSeen = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ViewersCompanion.insert(
            channelId: channelId,
            displayName: displayName,
            handle: handle,
            username: username,
            avatarUrl: avatarUrl,
            note: note,
            nameHistory: nameHistory,
            firstSeen: firstSeen,
            lastSeen: lastSeen,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ViewersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {chatMessagesRefs = false,
              superChatsRefs = false,
              membershipsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chatMessagesRefs) db.chatMessages,
                if (superChatsRefs) db.superChats,
                if (membershipsRefs) db.memberships
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatMessagesRefs)
                    await $_getPrefetchedData<Viewer, $ViewersTable,
                            ChatMessage>(
                        currentTable: table,
                        referencedTable:
                            $$ViewersTableReferences._chatMessagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ViewersTableReferences(db, table, p0)
                                .chatMessagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.channelId == item.channelId),
                        typedResults: items),
                  if (superChatsRefs)
                    await $_getPrefetchedData<Viewer, $ViewersTable, SuperChat>(
                        currentTable: table,
                        referencedTable:
                            $$ViewersTableReferences._superChatsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ViewersTableReferences(db, table, p0)
                                .superChatsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.channelId == item.channelId),
                        typedResults: items),
                  if (membershipsRefs)
                    await $_getPrefetchedData<Viewer, $ViewersTable,
                            Membership>(
                        currentTable: table,
                        referencedTable:
                            $$ViewersTableReferences._membershipsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ViewersTableReferences(db, table, p0)
                                .membershipsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.channelId == item.channelId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ViewersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ViewersTable,
    Viewer,
    $$ViewersTableFilterComposer,
    $$ViewersTableOrderingComposer,
    $$ViewersTableAnnotationComposer,
    $$ViewersTableCreateCompanionBuilder,
    $$ViewersTableUpdateCompanionBuilder,
    (Viewer, $$ViewersTableReferences),
    Viewer,
    PrefetchHooks Function(
        {bool chatMessagesRefs, bool superChatsRefs, bool membershipsRefs})>;
typedef $$ChatMessagesTableCreateCompanionBuilder = ChatMessagesCompanion
    Function({
  required String id,
  required String liveChatId,
  required String channelId,
  required String displayName,
  required String messageText,
  Value<String> type,
  Value<bool> isMember,
  required DateTime publishedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ChatMessagesTableUpdateCompanionBuilder = ChatMessagesCompanion
    Function({
  Value<String> id,
  Value<String> liveChatId,
  Value<String> channelId,
  Value<String> displayName,
  Value<String> messageText,
  Value<String> type,
  Value<bool> isMember,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ChatMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage> {
  $$ChatMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ViewersTable _channelIdTable(_$AppDatabase db) =>
      db.viewers.createAlias($_aliasNameGenerator(
          db.chatMessages.channelId, db.viewers.channelId));

  $$ViewersTableProcessedTableManager get channelId {
    final $_column = $_itemColumn<String>('channel_id')!;

    final manager = $$ViewersTableTableManager($_db, $_db.viewers)
        .filter((f) => f.channelId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMember => $composableBuilder(
      column: $table.isMember, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ViewersTableFilterComposer get channelId {
    final $$ViewersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableFilterComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMember => $composableBuilder(
      column: $table.isMember, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ViewersTableOrderingComposer get channelId {
    final $$ViewersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableOrderingComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isMember =>
      $composableBuilder(column: $table.isMember, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ViewersTableAnnotationComposer get channelId {
    final $$ViewersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableAnnotationComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatMessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (ChatMessage, $$ChatMessagesTableReferences),
    ChatMessage,
    PrefetchHooks Function({bool channelId})> {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> liveChatId = const Value.absent(),
            Value<String> channelId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> messageText = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> isMember = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessagesCompanion(
            id: id,
            liveChatId: liveChatId,
            channelId: channelId,
            displayName: displayName,
            messageText: messageText,
            type: type,
            isMember: isMember,
            publishedAt: publishedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String liveChatId,
            required String channelId,
            required String displayName,
            required String messageText,
            Value<String> type = const Value.absent(),
            Value<bool> isMember = const Value.absent(),
            required DateTime publishedAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessagesCompanion.insert(
            id: id,
            liveChatId: liveChatId,
            channelId: channelId,
            displayName: displayName,
            messageText: messageText,
            type: type,
            isMember: isMember,
            publishedAt: publishedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChatMessagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({channelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (channelId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.channelId,
                    referencedTable:
                        $$ChatMessagesTableReferences._channelIdTable(db),
                    referencedColumn: $$ChatMessagesTableReferences
                        ._channelIdTable(db)
                        .channelId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ChatMessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMessagesTable,
    ChatMessage,
    $$ChatMessagesTableFilterComposer,
    $$ChatMessagesTableOrderingComposer,
    $$ChatMessagesTableAnnotationComposer,
    $$ChatMessagesTableCreateCompanionBuilder,
    $$ChatMessagesTableUpdateCompanionBuilder,
    (ChatMessage, $$ChatMessagesTableReferences),
    ChatMessage,
    PrefetchHooks Function({bool channelId})>;
typedef $$SuperChatsTableCreateCompanionBuilder = SuperChatsCompanion Function({
  required String id,
  required String liveChatId,
  required String channelId,
  required String displayName,
  Value<String> messageText,
  required int amountMicros,
  required String currency,
  Value<String> tier,
  Value<String> type,
  Value<String> status,
  required DateTime publishedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$SuperChatsTableUpdateCompanionBuilder = SuperChatsCompanion Function({
  Value<String> id,
  Value<String> liveChatId,
  Value<String> channelId,
  Value<String> displayName,
  Value<String> messageText,
  Value<int> amountMicros,
  Value<String> currency,
  Value<String> tier,
  Value<String> type,
  Value<String> status,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SuperChatsTableReferences
    extends BaseReferences<_$AppDatabase, $SuperChatsTable, SuperChat> {
  $$SuperChatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ViewersTable _channelIdTable(_$AppDatabase db) =>
      db.viewers.createAlias(
          $_aliasNameGenerator(db.superChats.channelId, db.viewers.channelId));

  $$ViewersTableProcessedTableManager get channelId {
    final $_column = $_itemColumn<String>('channel_id')!;

    final manager = $$ViewersTableTableManager($_db, $_db.viewers)
        .filter((f) => f.channelId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SuperChatsTableFilterComposer
    extends Composer<_$AppDatabase, $SuperChatsTable> {
  $$SuperChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountMicros => $composableBuilder(
      column: $table.amountMicros, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ViewersTableFilterComposer get channelId {
    final $$ViewersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableFilterComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SuperChatsTableOrderingComposer
    extends Composer<_$AppDatabase, $SuperChatsTable> {
  $$SuperChatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountMicros => $composableBuilder(
      column: $table.amountMicros,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ViewersTableOrderingComposer get channelId {
    final $$ViewersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableOrderingComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SuperChatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuperChatsTable> {
  $$SuperChatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => column);

  GeneratedColumn<int> get amountMicros => $composableBuilder(
      column: $table.amountMicros, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ViewersTableAnnotationComposer get channelId {
    final $$ViewersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableAnnotationComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SuperChatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SuperChatsTable,
    SuperChat,
    $$SuperChatsTableFilterComposer,
    $$SuperChatsTableOrderingComposer,
    $$SuperChatsTableAnnotationComposer,
    $$SuperChatsTableCreateCompanionBuilder,
    $$SuperChatsTableUpdateCompanionBuilder,
    (SuperChat, $$SuperChatsTableReferences),
    SuperChat,
    PrefetchHooks Function({bool channelId})> {
  $$SuperChatsTableTableManager(_$AppDatabase db, $SuperChatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuperChatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuperChatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuperChatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> liveChatId = const Value.absent(),
            Value<String> channelId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> messageText = const Value.absent(),
            Value<int> amountMicros = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> tier = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SuperChatsCompanion(
            id: id,
            liveChatId: liveChatId,
            channelId: channelId,
            displayName: displayName,
            messageText: messageText,
            amountMicros: amountMicros,
            currency: currency,
            tier: tier,
            type: type,
            status: status,
            publishedAt: publishedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String liveChatId,
            required String channelId,
            required String displayName,
            Value<String> messageText = const Value.absent(),
            required int amountMicros,
            required String currency,
            Value<String> tier = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> status = const Value.absent(),
            required DateTime publishedAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SuperChatsCompanion.insert(
            id: id,
            liveChatId: liveChatId,
            channelId: channelId,
            displayName: displayName,
            messageText: messageText,
            amountMicros: amountMicros,
            currency: currency,
            tier: tier,
            type: type,
            status: status,
            publishedAt: publishedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SuperChatsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({channelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (channelId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.channelId,
                    referencedTable:
                        $$SuperChatsTableReferences._channelIdTable(db),
                    referencedColumn: $$SuperChatsTableReferences
                        ._channelIdTable(db)
                        .channelId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SuperChatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SuperChatsTable,
    SuperChat,
    $$SuperChatsTableFilterComposer,
    $$SuperChatsTableOrderingComposer,
    $$SuperChatsTableAnnotationComposer,
    $$SuperChatsTableCreateCompanionBuilder,
    $$SuperChatsTableUpdateCompanionBuilder,
    (SuperChat, $$SuperChatsTableReferences),
    SuperChat,
    PrefetchHooks Function({bool channelId})>;
typedef $$LiveStreamsTableCreateCompanionBuilder = LiveStreamsCompanion
    Function({
  Value<int> id,
  required String videoId,
  Value<String?> liveChatId,
  Value<String> title,
  Value<String> ownerChannelId,
  Value<String> ownerChannelName,
  required String url,
  Value<DateTime> connectedAt,
});
typedef $$LiveStreamsTableUpdateCompanionBuilder = LiveStreamsCompanion
    Function({
  Value<int> id,
  Value<String> videoId,
  Value<String?> liveChatId,
  Value<String> title,
  Value<String> ownerChannelId,
  Value<String> ownerChannelName,
  Value<String> url,
  Value<DateTime> connectedAt,
});

class $$LiveStreamsTableFilterComposer
    extends Composer<_$AppDatabase, $LiveStreamsTable> {
  $$LiveStreamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get videoId => $composableBuilder(
      column: $table.videoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerChannelId => $composableBuilder(
      column: $table.ownerChannelId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerChannelName => $composableBuilder(
      column: $table.ownerChannelName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get connectedAt => $composableBuilder(
      column: $table.connectedAt, builder: (column) => ColumnFilters(column));
}

class $$LiveStreamsTableOrderingComposer
    extends Composer<_$AppDatabase, $LiveStreamsTable> {
  $$LiveStreamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get videoId => $composableBuilder(
      column: $table.videoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerChannelId => $composableBuilder(
      column: $table.ownerChannelId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerChannelName => $composableBuilder(
      column: $table.ownerChannelName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get connectedAt => $composableBuilder(
      column: $table.connectedAt, builder: (column) => ColumnOrderings(column));
}

class $$LiveStreamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiveStreamsTable> {
  $$LiveStreamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get videoId =>
      $composableBuilder(column: $table.videoId, builder: (column) => column);

  GeneratedColumn<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get ownerChannelId => $composableBuilder(
      column: $table.ownerChannelId, builder: (column) => column);

  GeneratedColumn<String> get ownerChannelName => $composableBuilder(
      column: $table.ownerChannelName, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<DateTime> get connectedAt => $composableBuilder(
      column: $table.connectedAt, builder: (column) => column);
}

class $$LiveStreamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LiveStreamsTable,
    LiveStream,
    $$LiveStreamsTableFilterComposer,
    $$LiveStreamsTableOrderingComposer,
    $$LiveStreamsTableAnnotationComposer,
    $$LiveStreamsTableCreateCompanionBuilder,
    $$LiveStreamsTableUpdateCompanionBuilder,
    (LiveStream, BaseReferences<_$AppDatabase, $LiveStreamsTable, LiveStream>),
    LiveStream,
    PrefetchHooks Function()> {
  $$LiveStreamsTableTableManager(_$AppDatabase db, $LiveStreamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiveStreamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiveStreamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiveStreamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> videoId = const Value.absent(),
            Value<String?> liveChatId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> ownerChannelId = const Value.absent(),
            Value<String> ownerChannelName = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<DateTime> connectedAt = const Value.absent(),
          }) =>
              LiveStreamsCompanion(
            id: id,
            videoId: videoId,
            liveChatId: liveChatId,
            title: title,
            ownerChannelId: ownerChannelId,
            ownerChannelName: ownerChannelName,
            url: url,
            connectedAt: connectedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String videoId,
            Value<String?> liveChatId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> ownerChannelId = const Value.absent(),
            Value<String> ownerChannelName = const Value.absent(),
            required String url,
            Value<DateTime> connectedAt = const Value.absent(),
          }) =>
              LiveStreamsCompanion.insert(
            id: id,
            videoId: videoId,
            liveChatId: liveChatId,
            title: title,
            ownerChannelId: ownerChannelId,
            ownerChannelName: ownerChannelName,
            url: url,
            connectedAt: connectedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LiveStreamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LiveStreamsTable,
    LiveStream,
    $$LiveStreamsTableFilterComposer,
    $$LiveStreamsTableOrderingComposer,
    $$LiveStreamsTableAnnotationComposer,
    $$LiveStreamsTableCreateCompanionBuilder,
    $$LiveStreamsTableUpdateCompanionBuilder,
    (LiveStream, BaseReferences<_$AppDatabase, $LiveStreamsTable, LiveStream>),
    LiveStream,
    PrefetchHooks Function()>;
typedef $$MembershipsTableCreateCompanionBuilder = MembershipsCompanion
    Function({
  required String id,
  required String liveChatId,
  required String channelId,
  required String displayName,
  required String type,
  Value<String> messageText,
  Value<int> milestoneMonths,
  Value<int> giftCount,
  Value<String> membershipLevel,
  required DateTime publishedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$MembershipsTableUpdateCompanionBuilder = MembershipsCompanion
    Function({
  Value<String> id,
  Value<String> liveChatId,
  Value<String> channelId,
  Value<String> displayName,
  Value<String> type,
  Value<String> messageText,
  Value<int> milestoneMonths,
  Value<int> giftCount,
  Value<String> membershipLevel,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$MembershipsTableReferences
    extends BaseReferences<_$AppDatabase, $MembershipsTable, Membership> {
  $$MembershipsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ViewersTable _channelIdTable(_$AppDatabase db) =>
      db.viewers.createAlias(
          $_aliasNameGenerator(db.memberships.channelId, db.viewers.channelId));

  $$ViewersTableProcessedTableManager get channelId {
    final $_column = $_itemColumn<String>('channel_id')!;

    final manager = $$ViewersTableTableManager($_db, $_db.viewers)
        .filter((f) => f.channelId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MembershipsTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get milestoneMonths => $composableBuilder(
      column: $table.milestoneMonths,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get giftCount => $composableBuilder(
      column: $table.giftCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get membershipLevel => $composableBuilder(
      column: $table.membershipLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ViewersTableFilterComposer get channelId {
    final $$ViewersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableFilterComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MembershipsTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get milestoneMonths => $composableBuilder(
      column: $table.milestoneMonths,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get giftCount => $composableBuilder(
      column: $table.giftCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get membershipLevel => $composableBuilder(
      column: $table.membershipLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ViewersTableOrderingComposer get channelId {
    final $$ViewersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableOrderingComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MembershipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get liveChatId => $composableBuilder(
      column: $table.liveChatId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get messageText => $composableBuilder(
      column: $table.messageText, builder: (column) => column);

  GeneratedColumn<int> get milestoneMonths => $composableBuilder(
      column: $table.milestoneMonths, builder: (column) => column);

  GeneratedColumn<int> get giftCount =>
      $composableBuilder(column: $table.giftCount, builder: (column) => column);

  GeneratedColumn<String> get membershipLevel => $composableBuilder(
      column: $table.membershipLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ViewersTableAnnotationComposer get channelId {
    final $$ViewersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.channelId,
        referencedTable: $db.viewers,
        getReferencedColumn: (t) => t.channelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ViewersTableAnnotationComposer(
              $db: $db,
              $table: $db.viewers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MembershipsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MembershipsTable,
    Membership,
    $$MembershipsTableFilterComposer,
    $$MembershipsTableOrderingComposer,
    $$MembershipsTableAnnotationComposer,
    $$MembershipsTableCreateCompanionBuilder,
    $$MembershipsTableUpdateCompanionBuilder,
    (Membership, $$MembershipsTableReferences),
    Membership,
    PrefetchHooks Function({bool channelId})> {
  $$MembershipsTableTableManager(_$AppDatabase db, $MembershipsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembershipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembershipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> liveChatId = const Value.absent(),
            Value<String> channelId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> messageText = const Value.absent(),
            Value<int> milestoneMonths = const Value.absent(),
            Value<int> giftCount = const Value.absent(),
            Value<String> membershipLevel = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MembershipsCompanion(
            id: id,
            liveChatId: liveChatId,
            channelId: channelId,
            displayName: displayName,
            type: type,
            messageText: messageText,
            milestoneMonths: milestoneMonths,
            giftCount: giftCount,
            membershipLevel: membershipLevel,
            publishedAt: publishedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String liveChatId,
            required String channelId,
            required String displayName,
            required String type,
            Value<String> messageText = const Value.absent(),
            Value<int> milestoneMonths = const Value.absent(),
            Value<int> giftCount = const Value.absent(),
            Value<String> membershipLevel = const Value.absent(),
            required DateTime publishedAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MembershipsCompanion.insert(
            id: id,
            liveChatId: liveChatId,
            channelId: channelId,
            displayName: displayName,
            type: type,
            messageText: messageText,
            milestoneMonths: milestoneMonths,
            giftCount: giftCount,
            membershipLevel: membershipLevel,
            publishedAt: publishedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MembershipsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({channelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (channelId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.channelId,
                    referencedTable:
                        $$MembershipsTableReferences._channelIdTable(db),
                    referencedColumn: $$MembershipsTableReferences
                        ._channelIdTable(db)
                        .channelId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MembershipsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MembershipsTable,
    Membership,
    $$MembershipsTableFilterComposer,
    $$MembershipsTableOrderingComposer,
    $$MembershipsTableAnnotationComposer,
    $$MembershipsTableCreateCompanionBuilder,
    $$MembershipsTableUpdateCompanionBuilder,
    (Membership, $$MembershipsTableReferences),
    Membership,
    PrefetchHooks Function({bool channelId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ViewersTableTableManager get viewers =>
      $$ViewersTableTableManager(_db, _db.viewers);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$SuperChatsTableTableManager get superChats =>
      $$SuperChatsTableTableManager(_db, _db.superChats);
  $$LiveStreamsTableTableManager get liveStreams =>
      $$LiveStreamsTableTableManager(_db, _db.liveStreams);
  $$MembershipsTableTableManager get memberships =>
      $$MembershipsTableTableManager(_db, _db.memberships);
}
