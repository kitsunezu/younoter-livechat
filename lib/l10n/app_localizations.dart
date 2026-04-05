import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'YouNoter'**
  String get appTitle;

  /// No description provided for @chatTab.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatTab;

  /// No description provided for @superChatTab.
  ///
  /// In en, this message translates to:
  /// **'Super Chat'**
  String get superChatTab;

  /// No description provided for @dashboardTab.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @pasteUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Paste YouTube Live URL here...'**
  String get pasteUrlHint;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessages;

  /// No description provided for @viewerNote.
  ///
  /// In en, this message translates to:
  /// **'Viewer Note'**
  String get viewerNote;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNote;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveNote;

  /// No description provided for @cancelNote.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelNote;

  /// No description provided for @deleteNote.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteNote;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Enter note for this viewer...'**
  String get noteHint;

  /// No description provided for @viewerDetails.
  ///
  /// In en, this message translates to:
  /// **'Viewer Details'**
  String get viewerDetails;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @handle.
  ///
  /// In en, this message translates to:
  /// **'Handle'**
  String get handle;

  /// No description provided for @channelId.
  ///
  /// In en, this message translates to:
  /// **'Channel ID'**
  String get channelId;

  /// No description provided for @nameHistory.
  ///
  /// In en, this message translates to:
  /// **'Name History'**
  String get nameHistory;

  /// No description provided for @totalMessages.
  ///
  /// In en, this message translates to:
  /// **'Total Messages'**
  String get totalMessages;

  /// No description provided for @totalSuperChats.
  ///
  /// In en, this message translates to:
  /// **'Total Super Chats'**
  String get totalSuperChats;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @topDonors.
  ///
  /// In en, this message translates to:
  /// **'Top Donors'**
  String get topDonors;

  /// No description provided for @activeViewers.
  ///
  /// In en, this message translates to:
  /// **'Active Viewers'**
  String get activeViewers;

  /// No description provided for @markRead.
  ///
  /// In en, this message translates to:
  /// **'Mark Read'**
  String get markRead;

  /// No description provided for @markProcessed.
  ///
  /// In en, this message translates to:
  /// **'Mark Processed'**
  String get markProcessed;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @processed.
  ///
  /// In en, this message translates to:
  /// **'Processed'**
  String get processed;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @sortByAmount.
  ///
  /// In en, this message translates to:
  /// **'Sort by Amount'**
  String get sortByAmount;

  /// No description provided for @sortByTime.
  ///
  /// In en, this message translates to:
  /// **'Sort by Time'**
  String get sortByTime;

  /// No description provided for @sortByStatus.
  ///
  /// In en, this message translates to:
  /// **'Sort by Status'**
  String get sortByStatus;

  /// No description provided for @urlHistory.
  ///
  /// In en, this message translates to:
  /// **'URL History'**
  String get urlHistory;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistory;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @alwaysOnTop.
  ///
  /// In en, this message translates to:
  /// **'Always on Top'**
  String get alwaysOnTop;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @viewer.
  ///
  /// In en, this message translates to:
  /// **'Viewer'**
  String get viewer;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid YouTube Live URL'**
  String get invalidUrl;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error: {error}'**
  String connectionError(String error);

  /// No description provided for @chatCount.
  ///
  /// In en, this message translates to:
  /// **'{count} messages'**
  String chatCount(int count);

  /// No description provided for @superChatCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Super Chats'**
  String superChatCount(int count);

  /// No description provided for @superChatDistribution.
  ///
  /// In en, this message translates to:
  /// **'Super Chat Distribution'**
  String get superChatDistribution;

  /// No description provided for @currencyDistribution.
  ///
  /// In en, this message translates to:
  /// **'Currency Distribution'**
  String get currencyDistribution;

  /// No description provided for @noSuperChatDonors.
  ///
  /// In en, this message translates to:
  /// **'No Super Chat donors yet.'**
  String get noSuperChatDonors;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @connectToSeeStats.
  ///
  /// In en, this message translates to:
  /// **'Connect to a live stream to see statistics.'**
  String get connectToSeeStats;

  /// No description provided for @noteSaved.
  ///
  /// In en, this message translates to:
  /// **'Note saved'**
  String get noteSaved;

  /// No description provided for @viewerNotFound.
  ///
  /// In en, this message translates to:
  /// **'Viewer not found'**
  String get viewerNotFound;

  /// No description provided for @firstSeen.
  ///
  /// In en, this message translates to:
  /// **'First Seen'**
  String get firstSeen;

  /// No description provided for @lastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get lastSeen;

  /// No description provided for @apiKeyOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get apiKeyOptional;

  /// No description provided for @apiKeyOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'No API key required! The app works without one by scraping public chat data. Add a key for higher rate limits.'**
  String get apiKeyOptionalHint;

  /// No description provided for @apiKeyHelp.
  ///
  /// In en, this message translates to:
  /// **'Get your API key from Google Cloud Console → APIs & Services → Credentials'**
  String get apiKeyHelp;

  /// No description provided for @displayNameMode.
  ///
  /// In en, this message translates to:
  /// **'Display Name Mode'**
  String get displayNameMode;

  /// No description provided for @usernameAndHandle.
  ///
  /// In en, this message translates to:
  /// **'Name @Handle'**
  String get usernameAndHandle;

  /// No description provided for @usernameOnly.
  ///
  /// In en, this message translates to:
  /// **'Name Only'**
  String get usernameOnly;

  /// No description provided for @handleOnly.
  ///
  /// In en, this message translates to:
  /// **'@Handle Only'**
  String get handleOnly;

  /// No description provided for @counting.
  ///
  /// In en, this message translates to:
  /// **'Counting...'**
  String get counting;

  /// No description provided for @viewerSearchTab.
  ///
  /// In en, this message translates to:
  /// **'Viewers'**
  String get viewerSearchTab;

  /// No description provided for @searchViewerHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or handle...'**
  String get searchViewerHint;

  /// No description provided for @broadcasterChannel.
  ///
  /// In en, this message translates to:
  /// **'Broadcaster Channel'**
  String get broadcasterChannel;

  /// No description provided for @allChannels.
  ///
  /// In en, this message translates to:
  /// **'All Channels'**
  String get allChannels;

  /// No description provided for @noViewersFound.
  ///
  /// In en, this message translates to:
  /// **'No viewers found'**
  String get noViewersFound;

  /// No description provided for @chatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get chatHistory;

  /// No description provided for @superChatHistory.
  ///
  /// In en, this message translates to:
  /// **'Super Chat History'**
  String get superChatHistory;

  /// No description provided for @noChatHistory.
  ///
  /// In en, this message translates to:
  /// **'No chat history'**
  String get noChatHistory;

  /// No description provided for @noSuperChatHistory.
  ///
  /// In en, this message translates to:
  /// **'No Super Chat history'**
  String get noSuperChatHistory;

  /// No description provided for @streamInfo.
  ///
  /// In en, this message translates to:
  /// **'Stream Info'**
  String get streamInfo;

  /// No description provided for @connectedSince.
  ///
  /// In en, this message translates to:
  /// **'Connected Since'**
  String get connectedSince;

  /// No description provided for @deleteViewer.
  ///
  /// In en, this message translates to:
  /// **'Delete Viewer'**
  String get deleteViewer;

  /// No description provided for @deleteAllViewers.
  ///
  /// In en, this message translates to:
  /// **'Delete All Viewers'**
  String get deleteAllViewers;

  /// No description provided for @deleteViewerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this viewer and all their messages?'**
  String get deleteViewerConfirm;

  /// No description provided for @deleteAllViewersConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete ALL viewers and all their messages? This cannot be undone.'**
  String get deleteAllViewersConfirm;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @scrollToLatest.
  ///
  /// In en, this message translates to:
  /// **'Scroll to latest'**
  String get scrollToLatest;

  /// No description provided for @backToTop.
  ///
  /// In en, this message translates to:
  /// **'Back to top'**
  String get backToTop;

  /// No description provided for @deleteChannelData.
  ///
  /// In en, this message translates to:
  /// **'Delete Channel Data'**
  String get deleteChannelData;

  /// No description provided for @deleteChannelDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all messages, Super Chats and stream records for this broadcaster channel? Viewers with no remaining messages will also be removed. This cannot be undone.'**
  String get deleteChannelDataConfirm;

  /// No description provided for @deleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get deleteAllData;

  /// No description provided for @deleteAllDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete ALL messages, Super Chats, viewers and stream records? This cannot be undone.'**
  String get deleteAllDataConfirm;

  /// No description provided for @membershipTab.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membershipTab;

  /// No description provided for @newMembers.
  ///
  /// In en, this message translates to:
  /// **'New Members'**
  String get newMembers;

  /// No description provided for @giftedMemberships.
  ///
  /// In en, this message translates to:
  /// **'Gifted'**
  String get giftedMemberships;

  /// No description provided for @milestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get milestones;

  /// No description provided for @newMember.
  ///
  /// In en, this message translates to:
  /// **'New Member'**
  String get newMember;

  /// No description provided for @giftedMembership.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get giftedMembership;

  /// No description provided for @milestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get milestone;

  /// No description provided for @noMembershipEvents.
  ///
  /// In en, this message translates to:
  /// **'No membership events yet.'**
  String get noMembershipEvents;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get months;

  /// No description provided for @gifted.
  ///
  /// In en, this message translates to:
  /// **'gifted'**
  String get gifted;

  /// No description provided for @chatFontSize.
  ///
  /// In en, this message translates to:
  /// **'Chat Font Size'**
  String get chatFontSize;

  /// No description provided for @fontSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get fontSmall;

  /// No description provided for @fontMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get fontMedium;

  /// No description provided for @fontLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get fontLarge;

  /// No description provided for @highlightViewer.
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get highlightViewer;

  /// No description provided for @removeHighlight.
  ///
  /// In en, this message translates to:
  /// **'Remove Highlight'**
  String get removeHighlight;

  /// No description provided for @peakViewers.
  ///
  /// In en, this message translates to:
  /// **'Peak Viewers'**
  String get peakViewers;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'ja',
        'ko',
        'pt',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
