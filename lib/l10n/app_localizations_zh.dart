// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => '聊天室';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => '統計';

  @override
  String get settingsTab => '設定';

  @override
  String get pasteUrlHint => '貼上 YouTube 直播 URL...';

  @override
  String get connect => '連線';

  @override
  String get disconnect => '斷線';

  @override
  String get connecting => '連線中...';

  @override
  String get connected => '已連線';

  @override
  String get disconnected => '已斷線';

  @override
  String get noMessages => '尚無訊息';

  @override
  String get viewerNote => '觀眾備註';

  @override
  String get addNote => '新增備註';

  @override
  String get editNote => '編輯備註';

  @override
  String get saveNote => '儲存';

  @override
  String get cancelNote => '取消';

  @override
  String get deleteNote => '刪除';

  @override
  String get noteHint => '輸入此觀眾的備註...';

  @override
  String get viewerDetails => '觀眾詳細資料';

  @override
  String get displayName => '顯示名稱';

  @override
  String get handle => 'Handle';

  @override
  String get channelId => '頻道 ID';

  @override
  String get nameHistory => '歷史名稱';

  @override
  String get totalMessages => '總訊息數';

  @override
  String get totalSuperChats => 'Super Chat 總數';

  @override
  String get totalAmount => '總金額';

  @override
  String get topDonors => 'Top 捐贈者';

  @override
  String get activeViewers => '活躍觀眾';

  @override
  String get markRead => '標記已讀';

  @override
  String get markProcessed => '標記已處理';

  @override
  String get unread => '未讀';

  @override
  String get read => '已讀';

  @override
  String get processed => '已處理';

  @override
  String get filterAll => '全部';

  @override
  String get searchHint => '搜尋...';

  @override
  String get sortByAmount => '依金額排序';

  @override
  String get sortByTime => '依時間排序';

  @override
  String get sortByStatus => '依狀態排序';

  @override
  String get urlHistory => 'URL 歷史記錄';

  @override
  String get clearHistory => '清除記錄';

  @override
  String get darkMode => '深色模式';

  @override
  String get lightMode => '淺色模式';

  @override
  String get alwaysOnTop => '視窗置頂';

  @override
  String get language => '語言';

  @override
  String get amount => '金額';

  @override
  String get message => '訊息';

  @override
  String get time => '時間';

  @override
  String get viewer => '觀眾';

  @override
  String get status => '狀態';

  @override
  String get invalidUrl => '無效的 YouTube 直播 URL';

  @override
  String connectionError(String error) {
    return '連線錯誤：$error';
  }

  @override
  String chatCount(int count) {
    return '$count 則訊息';
  }

  @override
  String superChatCount(int count) {
    return '$count 則 Super Chat';
  }

  @override
  String get superChatDistribution => 'Super Chat 分佈';

  @override
  String get currencyDistribution => '貨幣比例分佈';

  @override
  String get noSuperChatDonors => '尚無 Super Chat 捐贈者。';

  @override
  String get noData => '無資料';

  @override
  String get connectToSeeStats => '請先連線直播以查看統計資料。';

  @override
  String get noteSaved => '備註已儲存';

  @override
  String get viewerNotFound => '找不到觀眾';

  @override
  String get firstSeen => '首次出現';

  @override
  String get lastSeen => '最後出現';

  @override
  String get apiKeyOptional => '選填';

  @override
  String get apiKeyOptionalHint =>
      '不需要 API Key 即可使用！應用程式會透過網頁擷取公開聊天室資料。輸入 API Key 可提高請求限制。';

  @override
  String get apiKeyHelp =>
      '從 Google Cloud Console → APIs & Services → Credentials 取得 API Key';

  @override
  String get displayNameMode => '顯示名稱模式';

  @override
  String get usernameAndHandle => '名稱 @Handle';

  @override
  String get usernameOnly => '僅名稱';

  @override
  String get handleOnly => '僅 @Handle';

  @override
  String get counting => '統計中...';

  @override
  String get viewerSearchTab => '觀眾';

  @override
  String get searchViewerHint => '搜尋名稱或 Handle...';

  @override
  String get broadcasterChannel => '直播主頻道';

  @override
  String get allChannels => '全部頻道';

  @override
  String get noViewersFound => '找不到觀眾';

  @override
  String get chatHistory => '聊天記錄';

  @override
  String get superChatHistory => 'Super Chat 記錄';

  @override
  String get noChatHistory => '無聊天記錄';

  @override
  String get noSuperChatHistory => '無 Super Chat 記錄';

  @override
  String get streamInfo => '直播資訊';

  @override
  String get connectedSince => '連線時間';

  @override
  String get deleteViewer => '刪除觀眾';

  @override
  String get deleteAllViewers => '刪除全部觀眾';

  @override
  String get deleteViewerConfirm => '確定刪除此觀眾及其所有訊息？';

  @override
  String get deleteAllViewersConfirm => '確定刪除所有觀眾及其所有訊息？此操作無法復原。';

  @override
  String get confirm => '確認';

  @override
  String get cancel => '取消';

  @override
  String get scrollToLatest => '跳至最新';

  @override
  String get backToTop => '回到頂部';

  @override
  String get deleteChannelData => '刪除頻道資料';

  @override
  String get deleteChannelDataConfirm =>
      '確定刪除此直播主頻道的所有訊息、Super Chat 及直播記錄？沒有留言的觀眾也會一併移除。此操作無法復原。';

  @override
  String get deleteAllData => '刪除全部資料';

  @override
  String get deleteAllDataConfirm => '確定刪除所有訊息、Super Chat、觀眾及直播記錄？此操作無法復原。';

  @override
  String get membershipTab => '會員';

  @override
  String get newMembers => '新會員';

  @override
  String get giftedMemberships => '贈送會員';

  @override
  String get milestones => '里程碑';

  @override
  String get newMember => '新會員';

  @override
  String get giftedMembership => '贈送';

  @override
  String get milestone => '里程碑';

  @override
  String get noMembershipEvents => '尚無會員事件。';

  @override
  String get months => '個月';

  @override
  String get gifted => '次贈送';

  @override
  String get chatFontSize => '聊天室字體大小';

  @override
  String get fontSmall => '小';

  @override
  String get fontMedium => '中';

  @override
  String get fontLarge => '大';

  @override
  String get highlightViewer => '標記';

  @override
  String get removeHighlight => '取消標記';

  @override
  String get peakViewers => '最高同時人數';
}
