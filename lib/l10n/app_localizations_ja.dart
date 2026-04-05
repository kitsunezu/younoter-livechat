// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => 'チャット';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => 'ダッシュボード';

  @override
  String get settingsTab => '設定';

  @override
  String get pasteUrlHint => 'YouTube ライブURLを貼り付け...';

  @override
  String get connect => '接続';

  @override
  String get disconnect => '切断';

  @override
  String get connecting => '接続中...';

  @override
  String get connected => '接続済み';

  @override
  String get disconnected => '未接続';

  @override
  String get noMessages => 'メッセージはまだありません';

  @override
  String get viewerNote => '視聴者メモ';

  @override
  String get addNote => 'メモを追加';

  @override
  String get editNote => 'メモを編集';

  @override
  String get saveNote => '保存';

  @override
  String get cancelNote => 'キャンセル';

  @override
  String get deleteNote => '削除';

  @override
  String get noteHint => 'この視聴者のメモを入力...';

  @override
  String get viewerDetails => '視聴者詳細';

  @override
  String get displayName => '表示名';

  @override
  String get handle => 'ハンドル';

  @override
  String get channelId => 'チャンネルID';

  @override
  String get nameHistory => '名前履歴';

  @override
  String get totalMessages => '総メッセージ数';

  @override
  String get totalSuperChats => 'Super Chat合計';

  @override
  String get totalAmount => '合計金額';

  @override
  String get topDonors => 'トップドナー';

  @override
  String get activeViewers => 'アクティブ視聴者';

  @override
  String get markRead => '既読にする';

  @override
  String get markProcessed => '処理済みにする';

  @override
  String get unread => '未読';

  @override
  String get read => '既読';

  @override
  String get processed => '処理済み';

  @override
  String get filterAll => 'すべて';

  @override
  String get searchHint => '検索...';

  @override
  String get sortByAmount => '金額順';

  @override
  String get sortByTime => '時間順';

  @override
  String get sortByStatus => '状態順';

  @override
  String get urlHistory => 'URL履歴';

  @override
  String get clearHistory => '履歴をクリア';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get alwaysOnTop => '常に最前面';

  @override
  String get language => '言語';

  @override
  String get amount => '金額';

  @override
  String get message => 'メッセージ';

  @override
  String get time => '時間';

  @override
  String get viewer => '視聴者';

  @override
  String get status => '状態';

  @override
  String get invalidUrl => '無効なYouTubeライブURL';

  @override
  String connectionError(String error) {
    return '接続エラー：$error';
  }

  @override
  String chatCount(int count) {
    return '$count 件のメッセージ';
  }

  @override
  String superChatCount(int count) {
    return '$count 件のSuper Chat';
  }

  @override
  String get superChatDistribution => 'Super Chat 分布';

  @override
  String get currencyDistribution => '通貨別分布';

  @override
  String get noSuperChatDonors => 'Super Chatのドナーはまだいません。';

  @override
  String get noData => 'データなし';

  @override
  String get connectToSeeStats => 'ライブ配信に接続して統計を表示します。';

  @override
  String get noteSaved => 'メモを保存しました';

  @override
  String get viewerNotFound => '視聴者が見つかりません';

  @override
  String get firstSeen => '初出現';

  @override
  String get lastSeen => '最終出現';

  @override
  String get apiKeyOptional => '任意';

  @override
  String get apiKeyOptionalHint =>
      'API Keyなしで利用可能！アプリは公開チャットデータをスクレイピングします。API Keyを設定するとレート制限が緩和されます。';

  @override
  String get apiKeyHelp =>
      'Google Cloud Console → APIs & Services → Credentials からAPI Keyを取得';

  @override
  String get displayNameMode => '表示名モード';

  @override
  String get usernameAndHandle => '名前 @ハンドル';

  @override
  String get usernameOnly => '名前のみ';

  @override
  String get handleOnly => '@ハンドルのみ';

  @override
  String get counting => '集計中...';

  @override
  String get viewerSearchTab => '視聴者';

  @override
  String get searchViewerHint => '名前またはハンドルで検索...';

  @override
  String get broadcasterChannel => '配信者チャンネル';

  @override
  String get allChannels => 'すべてのチャンネル';

  @override
  String get noViewersFound => '視聴者が見つかりません';

  @override
  String get chatHistory => 'チャット履歴';

  @override
  String get superChatHistory => 'Super Chat 履歴';

  @override
  String get noChatHistory => 'チャット履歴なし';

  @override
  String get noSuperChatHistory => 'Super Chat 履歴なし';

  @override
  String get streamInfo => '配信情報';

  @override
  String get connectedSince => '接続開始';

  @override
  String get deleteViewer => '視聴者を削除';

  @override
  String get deleteAllViewers => '全視聴者を削除';

  @override
  String get deleteViewerConfirm => 'この視聴者とすべてのメッセージを削除しますか？';

  @override
  String get deleteAllViewersConfirm => 'すべての視聴者とメッセージを削除しますか？この操作は元に戻せません。';

  @override
  String get confirm => '確認';

  @override
  String get cancel => 'キャンセル';

  @override
  String get scrollToLatest => '最新へ移動';

  @override
  String get backToTop => '先頭へ戻る';

  @override
  String get deleteChannelData => 'チャンネルデータを削除';

  @override
  String get deleteChannelDataConfirm =>
      'この配信者チャンネルのすべてのメッセージ、Super Chat、配信記録を削除しますか？メッセージのない視聴者も削除されます。この操作は元に戻せません。';

  @override
  String get deleteAllData => '全データを削除';

  @override
  String get deleteAllDataConfirm =>
      'すべてのメッセージ、Super Chat、視聴者、配信記録を削除しますか？この操作は元に戻せません。';

  @override
  String get membershipTab => 'メンバーシップ';

  @override
  String get newMembers => '新規メンバー';

  @override
  String get giftedMemberships => 'ギフト';

  @override
  String get milestones => 'マイルストーン';

  @override
  String get newMember => '新規メンバー';

  @override
  String get giftedMembership => 'ギフト';

  @override
  String get milestone => 'マイルストーン';

  @override
  String get noMembershipEvents => 'メンバーシップイベントはまだありません。';

  @override
  String get months => 'ヶ月';

  @override
  String get gifted => '件ギフト';

  @override
  String get chatFontSize => 'チャット文字サイズ';

  @override
  String get fontSmall => '小';

  @override
  String get fontMedium => '中';

  @override
  String get fontLarge => '大';

  @override
  String get highlightViewer => 'ハイライト';

  @override
  String get removeHighlight => 'ハイライト解除';

  @override
  String get peakViewers => '最大同時視聴者数';
}
