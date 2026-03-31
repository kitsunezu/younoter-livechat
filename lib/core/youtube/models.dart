/// Represents a single chat message from the YouTube Live Chat API.
class LiveChatMessage {
  final String id;
  final String type; // textMessageEvent, superChatEvent, superStickerEvent, etc.
  final String authorChannelId;
  final String authorDisplayName;
  final String authorHandle;
  final String authorAvatarUrl;
  final String messageText;
  final DateTime publishedAt;

  // Super Chat fields
  final int? amountMicros;
  final String? currency;
  final String? tier;

  // Member (sponsor) status
  final bool isMember;

  // Membership event fields
  final int? milestoneMonths;
  final int? giftCount;
  final String? membershipLevel;

  bool get isSuperChat =>
      type == 'superChatEvent' || type == 'superStickerEvent';

  bool get isMembershipEvent =>
      type == 'newSponsorEvent' ||
      type == 'membershipGiftingEvent' ||
      type == 'memberMilestoneChatEvent';

  double? get amountDisplay =>
      amountMicros != null ? amountMicros! / 1000000.0 : null;

  LiveChatMessage({
    required this.id,
    required this.type,
    required this.authorChannelId,
    required this.authorDisplayName,
    this.authorHandle = '',
    this.authorAvatarUrl = '',
    required this.messageText,
    required this.publishedAt,
    this.amountMicros,
    this.currency,
    this.tier,
    this.isMember = false,
    this.milestoneMonths,
    this.giftCount,
    this.membershipLevel,
  });
}

class LiveStreamInfo {
  final String videoId;
  final String liveChatId;
  final String title;
  final String ownerChannelId;
  final String ownerChannelName;

  const LiveStreamInfo({
    required this.videoId,
    required this.liveChatId,
    this.title = '',
    this.ownerChannelId = '',
    this.ownerChannelName = '',
  });
}

/// Result of polling live chat messages.
class LiveChatPollResult {
  final List<LiveChatMessage> messages;
  final String? nextPageToken;
  final int pollingIntervalMillis;
  final bool isFinished;

  LiveChatPollResult({
    required this.messages,
    this.nextPageToken,
    this.pollingIntervalMillis = 5000,
    this.isFinished = false,
  });
}
