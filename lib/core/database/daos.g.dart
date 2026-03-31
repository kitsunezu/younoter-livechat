// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$ViewerDaoMixin on DatabaseAccessor<AppDatabase> {
  $ViewersTable get viewers => attachedDatabase.viewers;
  $ChatMessagesTable get chatMessages => attachedDatabase.chatMessages;
  $LiveStreamsTable get liveStreams => attachedDatabase.liveStreams;
}
mixin _$ChatMessageDaoMixin on DatabaseAccessor<AppDatabase> {
  $ViewersTable get viewers => attachedDatabase.viewers;
  $ChatMessagesTable get chatMessages => attachedDatabase.chatMessages;
  $LiveStreamsTable get liveStreams => attachedDatabase.liveStreams;
}
mixin _$SuperChatDaoMixin on DatabaseAccessor<AppDatabase> {
  $ViewersTable get viewers => attachedDatabase.viewers;
  $SuperChatsTable get superChats => attachedDatabase.superChats;
  $LiveStreamsTable get liveStreams => attachedDatabase.liveStreams;
}
mixin _$LiveStreamDaoMixin on DatabaseAccessor<AppDatabase> {
  $LiveStreamsTable get liveStreams => attachedDatabase.liveStreams;
  $ViewersTable get viewers => attachedDatabase.viewers;
  $ChatMessagesTable get chatMessages => attachedDatabase.chatMessages;
  $SuperChatsTable get superChats => attachedDatabase.superChats;
  $MembershipsTable get memberships => attachedDatabase.memberships;
}
mixin _$MembershipDaoMixin on DatabaseAccessor<AppDatabase> {
  $ViewersTable get viewers => attachedDatabase.viewers;
  $MembershipsTable get memberships => attachedDatabase.memberships;
  $LiveStreamsTable get liveStreams => attachedDatabase.liveStreams;
}
