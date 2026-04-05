// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => 'Chat';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get settingsTab => 'Settings';

  @override
  String get pasteUrlHint => 'Paste YouTube Live URL here...';

  @override
  String get connect => 'Connect';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get connecting => 'Connecting...';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get noMessages => 'No messages yet';

  @override
  String get viewerNote => 'Viewer Note';

  @override
  String get addNote => 'Add Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get saveNote => 'Save';

  @override
  String get cancelNote => 'Cancel';

  @override
  String get deleteNote => 'Delete';

  @override
  String get noteHint => 'Enter note for this viewer...';

  @override
  String get viewerDetails => 'Viewer Details';

  @override
  String get displayName => 'Display Name';

  @override
  String get handle => 'Handle';

  @override
  String get channelId => 'Channel ID';

  @override
  String get nameHistory => 'Name History';

  @override
  String get totalMessages => 'Total Messages';

  @override
  String get totalSuperChats => 'Total Super Chats';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get topDonors => 'Top Donors';

  @override
  String get activeViewers => 'Active Viewers';

  @override
  String get markRead => 'Mark Read';

  @override
  String get markProcessed => 'Mark Processed';

  @override
  String get unread => 'Unread';

  @override
  String get read => 'Read';

  @override
  String get processed => 'Processed';

  @override
  String get filterAll => 'All';

  @override
  String get searchHint => 'Search...';

  @override
  String get sortByAmount => 'Sort by Amount';

  @override
  String get sortByTime => 'Sort by Time';

  @override
  String get sortByStatus => 'Sort by Status';

  @override
  String get urlHistory => 'URL History';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get alwaysOnTop => 'Always on Top';

  @override
  String get language => 'Language';

  @override
  String get amount => 'Amount';

  @override
  String get message => 'Message';

  @override
  String get time => 'Time';

  @override
  String get viewer => 'Viewer';

  @override
  String get status => 'Status';

  @override
  String get invalidUrl => 'Invalid YouTube Live URL';

  @override
  String connectionError(String error) {
    return 'Connection error: $error';
  }

  @override
  String chatCount(int count) {
    return '$count messages';
  }

  @override
  String superChatCount(int count) {
    return '$count Super Chats';
  }

  @override
  String get superChatDistribution => 'Super Chat Distribution';

  @override
  String get currencyDistribution => 'Currency Distribution';

  @override
  String get noSuperChatDonors => 'No Super Chat donors yet.';

  @override
  String get noData => 'No data';

  @override
  String get connectToSeeStats => 'Connect to a live stream to see statistics.';

  @override
  String get noteSaved => 'Note saved';

  @override
  String get viewerNotFound => 'Viewer not found';

  @override
  String get firstSeen => 'First Seen';

  @override
  String get lastSeen => 'Last Seen';

  @override
  String get apiKeyOptional => 'Optional';

  @override
  String get apiKeyOptionalHint =>
      'No API key required! The app works without one by scraping public chat data. Add a key for higher rate limits.';

  @override
  String get apiKeyHelp =>
      'Get your API key from Google Cloud Console → APIs & Services → Credentials';

  @override
  String get displayNameMode => 'Display Name Mode';

  @override
  String get usernameAndHandle => 'Name @Handle';

  @override
  String get usernameOnly => 'Name Only';

  @override
  String get handleOnly => '@Handle Only';

  @override
  String get counting => 'Counting...';

  @override
  String get viewerSearchTab => 'Viewers';

  @override
  String get searchViewerHint => 'Search by name or handle...';

  @override
  String get broadcasterChannel => 'Broadcaster Channel';

  @override
  String get allChannels => 'All Channels';

  @override
  String get noViewersFound => 'No viewers found';

  @override
  String get chatHistory => 'Chat History';

  @override
  String get superChatHistory => 'Super Chat History';

  @override
  String get noChatHistory => 'No chat history';

  @override
  String get noSuperChatHistory => 'No Super Chat history';

  @override
  String get streamInfo => 'Stream Info';

  @override
  String get connectedSince => 'Connected Since';

  @override
  String get deleteViewer => 'Delete Viewer';

  @override
  String get deleteAllViewers => 'Delete All Viewers';

  @override
  String get deleteViewerConfirm =>
      'Delete this viewer and all their messages?';

  @override
  String get deleteAllViewersConfirm =>
      'Delete ALL viewers and all their messages? This cannot be undone.';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get scrollToLatest => 'Scroll to latest';

  @override
  String get backToTop => 'Back to top';

  @override
  String get deleteChannelData => 'Delete Channel Data';

  @override
  String get deleteChannelDataConfirm =>
      'Delete all messages, Super Chats and stream records for this broadcaster channel? Viewers with no remaining messages will also be removed. This cannot be undone.';

  @override
  String get deleteAllData => 'Delete All Data';

  @override
  String get deleteAllDataConfirm =>
      'Delete ALL messages, Super Chats, viewers and stream records? This cannot be undone.';

  @override
  String get membershipTab => 'Membership';

  @override
  String get newMembers => 'New Members';

  @override
  String get giftedMemberships => 'Gifted';

  @override
  String get milestones => 'Milestones';

  @override
  String get newMember => 'New Member';

  @override
  String get giftedMembership => 'Gift';

  @override
  String get milestone => 'Milestone';

  @override
  String get noMembershipEvents => 'No membership events yet.';

  @override
  String get months => 'months';

  @override
  String get gifted => 'gifted';

  @override
  String get chatFontSize => 'Chat Font Size';

  @override
  String get fontSmall => 'Small';

  @override
  String get fontMedium => 'Medium';

  @override
  String get fontLarge => 'Large';

  @override
  String get highlightViewer => 'Highlight';

  @override
  String get removeHighlight => 'Remove Highlight';

  @override
  String get peakViewers => 'Peak Viewers';
}
