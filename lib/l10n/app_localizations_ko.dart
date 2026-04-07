// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => '채팅';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => '대시보드';

  @override
  String get settingsTab => '설정';

  @override
  String get pasteUrlHint => 'YouTube 라이브 URL을 붙여넣기...';

  @override
  String get connect => '연결';

  @override
  String get disconnect => '연결 해제';

  @override
  String get connecting => '연결 중...';

  @override
  String get connected => '연결됨';

  @override
  String get disconnected => '연결 안 됨';

  @override
  String get noMessages => '메시지가 없습니다';

  @override
  String get viewerNote => '시청자 메모';

  @override
  String get addNote => '메모 추가';

  @override
  String get editNote => '메모 편집';

  @override
  String get saveNote => '저장';

  @override
  String get cancelNote => '취소';

  @override
  String get deleteNote => '삭제';

  @override
  String get noteHint => '이 시청자에 대한 메모를 입력...';

  @override
  String get viewerDetails => '시청자 상세정보';

  @override
  String get displayName => '표시 이름';

  @override
  String get handle => '핸들';

  @override
  String get channelId => '채널 ID';

  @override
  String get nameHistory => '이름 기록';

  @override
  String get totalMessages => '총 메시지 수';

  @override
  String get totalSuperChats => 'Super Chat 합계';

  @override
  String get totalAmount => '총 금액';

  @override
  String get topDonors => '상위 후원자';

  @override
  String get top5Donors => 'Top 5 후원자';

  @override
  String get activeViewers => '활성 시청자';

  @override
  String get markRead => '읽음으로 표시';

  @override
  String get markProcessed => '처리됨으로 표시';

  @override
  String get unread => '읽지 않음';

  @override
  String get read => '읽음';

  @override
  String get processed => '처리됨';

  @override
  String get filterAll => '전체';

  @override
  String get searchHint => '검색...';

  @override
  String get sortByAmount => '금액순';

  @override
  String get sortByTime => '시간순';

  @override
  String get sortByStatus => '상태순';

  @override
  String get urlHistory => 'URL 기록';

  @override
  String get clearHistory => '기록 삭제';

  @override
  String get darkMode => '다크 모드';

  @override
  String get lightMode => '라이트 모드';

  @override
  String get alwaysOnTop => '항상 위에 표시';

  @override
  String get language => '언어';

  @override
  String get amount => '금액';

  @override
  String get message => '메시지';

  @override
  String get time => '시간';

  @override
  String get viewer => '시청자';

  @override
  String get status => '상태';

  @override
  String get invalidUrl => '유효하지 않은 YouTube 라이브 URL';

  @override
  String connectionError(String error) {
    return '연결 오류: $error';
  }

  @override
  String chatCount(int count) {
    return '$count개 메시지';
  }

  @override
  String superChatCount(int count) {
    return '$count개 Super Chat';
  }

  @override
  String get superChatDistribution => 'Super Chat 분포';

  @override
  String get currencyDistribution => '통화별 분포';

  @override
  String get noSuperChatDonors => '아직 Super Chat 후원자가 없습니다.';

  @override
  String get noData => '데이터 없음';

  @override
  String get connectToSeeStats => '라이브 방송에 연결하여 통계를 확인하세요.';

  @override
  String get noteSaved => '메모가 저장되었습니다';

  @override
  String get viewerNotFound => '시청자를 찾을 수 없습니다';

  @override
  String get firstSeen => '첫 등장';

  @override
  String get lastSeen => '마지막 등장';

  @override
  String get apiKeyOptional => '선택 사항';

  @override
  String get apiKeyOptionalHint =>
      'API Key 없이 사용 가능! 앱이 공개 채팅 데이터를 스크래핑합니다. API Key를 추가하면 요청 제한이 완화됩니다.';

  @override
  String get apiKeyHelp =>
      'Google Cloud Console → APIs & Services → Credentials에서 API Key를 발급받으세요';

  @override
  String get displayNameMode => '표시 이름 모드';

  @override
  String get usernameAndHandle => '이름 @핸들';

  @override
  String get usernameOnly => '이름만';

  @override
  String get handleOnly => '@핸들만';

  @override
  String get counting => '집계 중...';

  @override
  String get viewerSearchTab => '시청자';

  @override
  String get searchViewerHint => '이름 또는 핸들로 검색...';

  @override
  String get broadcasterChannel => '방송 채널';

  @override
  String get allChannels => '전체 채널';

  @override
  String get noViewersFound => '시청자를 찾을 수 없습니다';

  @override
  String get chatHistory => '채팅 기록';

  @override
  String get superChatHistory => 'Super Chat 기록';

  @override
  String get noChatHistory => '채팅 기록 없음';

  @override
  String get noSuperChatHistory => 'Super Chat 기록 없음';

  @override
  String get streamInfo => '방송 정보';

  @override
  String get connectedSince => '연결 시작';

  @override
  String get deleteViewer => '시청자 삭제';

  @override
  String get deleteAllViewers => '전체 시청자 삭제';

  @override
  String get deleteViewerConfirm => '이 시청자와 모든 메시지를 삭제하시겠습니까?';

  @override
  String get deleteAllViewersConfirm =>
      '모든 시청자와 메시지를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get confirm => '확인';

  @override
  String get cancel => '취소';

  @override
  String get scrollToLatest => '최신으로 이동';

  @override
  String get backToTop => '맨 위로';

  @override
  String get deleteChannelData => '채널 데이터 삭제';

  @override
  String get deleteChannelDataConfirm =>
      '이 방송 채널의 모든 메시지, Super Chat 및 방송 기록을 삭제하시겠습니까? 메시지가 없는 시청자도 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get deleteAllData => '전체 데이터 삭제';

  @override
  String get deleteAllDataConfirm =>
      '모든 메시지, Super Chat, 시청자 및 방송 기록을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get membershipTab => '멤버십';

  @override
  String get newMembers => '신규 멤버';

  @override
  String get giftedMemberships => '선물';

  @override
  String get milestones => '마일스톤';

  @override
  String get newMember => '신규 멤버';

  @override
  String get giftedMembership => '선물';

  @override
  String get milestone => '마일스톤';

  @override
  String get noMembershipEvents => '아직 멤버십 이벤트가 없습니다.';

  @override
  String get months => '개월';

  @override
  String get gifted => '건 선물';

  @override
  String get chatFontSize => '채팅 글꼴 크기';

  @override
  String get fontSmall => '작게';

  @override
  String get fontMedium => '보통';

  @override
  String get fontLarge => '크게';

  @override
  String get highlightViewer => '하이라이트';

  @override
  String get removeHighlight => '하이라이트 해제';

  @override
  String get peakViewers => '최대 동시 시청자';
}
