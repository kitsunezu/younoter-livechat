// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => 'Chat';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get settingsTab => 'Einstellungen';

  @override
  String get pasteUrlHint => 'YouTube-Livestream-URL hier einfügen...';

  @override
  String get connect => 'Verbinden';

  @override
  String get disconnect => 'Trennen';

  @override
  String get connecting => 'Verbinde...';

  @override
  String get connected => 'Verbunden';

  @override
  String get disconnected => 'Getrennt';

  @override
  String get noMessages => 'Noch keine Nachrichten';

  @override
  String get viewerNote => 'Zuschauer-Notiz';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get editNote => 'Notiz bearbeiten';

  @override
  String get saveNote => 'Speichern';

  @override
  String get cancelNote => 'Abbrechen';

  @override
  String get deleteNote => 'Löschen';

  @override
  String get noteHint => 'Notiz für diesen Zuschauer eingeben...';

  @override
  String get viewerDetails => 'Zuschauer-Details';

  @override
  String get displayName => 'Anzeigename';

  @override
  String get handle => 'Handle';

  @override
  String get channelId => 'Kanal-ID';

  @override
  String get nameHistory => 'Namensverlauf';

  @override
  String get totalMessages => 'Nachrichten gesamt';

  @override
  String get totalSuperChats => 'Super Chats gesamt';

  @override
  String get totalAmount => 'Gesamtbetrag';

  @override
  String get topDonors => 'Top-Spender';

  @override
  String get top5Donors => 'Top 5 Spender';

  @override
  String get activeViewers => 'Aktive Zuschauer';

  @override
  String get markRead => 'Als gelesen markieren';

  @override
  String get markProcessed => 'Als bearbeitet markieren';

  @override
  String get unread => 'Ungelesen';

  @override
  String get read => 'Gelesen';

  @override
  String get processed => 'Bearbeitet';

  @override
  String get filterAll => 'Alle';

  @override
  String get searchHint => 'Suchen...';

  @override
  String get searchMessages => 'Nachrichten suchen';

  @override
  String get noMatchingMessages => 'Keine passenden Nachrichten';

  @override
  String get markUnread => 'Als ungelesen markieren';

  @override
  String get sortByAmount => 'Nach Betrag';

  @override
  String get sortByTime => 'Nach Zeit';

  @override
  String get sortByStatus => 'Nach Status';

  @override
  String get urlHistory => 'URL-Verlauf';

  @override
  String get clearHistory => 'Verlauf löschen';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get lightMode => 'Hellmodus';

  @override
  String get alwaysOnTop => 'Immer im Vordergrund';

  @override
  String get language => 'Sprache';

  @override
  String get amount => 'Betrag';

  @override
  String get message => 'Nachricht';

  @override
  String get time => 'Zeit';

  @override
  String get viewer => 'Zuschauer';

  @override
  String get status => 'Status';

  @override
  String get invalidUrl => 'Ungültige YouTube-Livestream-URL';

  @override
  String connectionError(String error) {
    return 'Verbindungsfehler: $error';
  }

  @override
  String chatCount(int count) {
    return '$count Nachrichten';
  }

  @override
  String superChatCount(int count) {
    return '$count Super Chats';
  }

  @override
  String get superChatDistribution => 'Super-Chat-Verteilung';

  @override
  String get currencyDistribution => 'Währungsverteilung';

  @override
  String get noSuperChatDonors => 'Noch keine Super-Chat-Spender.';

  @override
  String get noData => 'Keine Daten';

  @override
  String get connectToSeeStats =>
      'Verbinde dich mit einem Livestream, um Statistiken anzuzeigen.';

  @override
  String get noteSaved => 'Notiz gespeichert';

  @override
  String get viewerNotFound => 'Zuschauer nicht gefunden';

  @override
  String get firstSeen => 'Erstmals gesehen';

  @override
  String get lastSeen => 'Zuletzt gesehen';

  @override
  String get apiKeyOptional => 'Optional';

  @override
  String get apiKeyOptionalHint =>
      'Kein API-Key erforderlich! Die App funktioniert ohne, indem sie öffentliche Chat-Daten ausliest. Füge einen Key hinzu für höhere Anfragelimits.';

  @override
  String get apiKeyHelp =>
      'API-Key in Google Cloud Console → APIs & Services → Credentials erstellen';

  @override
  String get displayNameMode => 'Anzeigenamenmodus';

  @override
  String get usernameAndHandle => 'Name @Handle';

  @override
  String get usernameOnly => 'Nur Name';

  @override
  String get handleOnly => 'Nur @Handle';

  @override
  String get counting => 'Zähle...';

  @override
  String get viewerSearchTab => 'Zuschauer';

  @override
  String get searchViewerHint => 'Nach Name oder Handle suchen...';

  @override
  String get broadcasterChannel => 'Streamer-Kanal';

  @override
  String get allChannels => 'Alle Kanäle';

  @override
  String get noViewersFound => 'Keine Zuschauer gefunden';

  @override
  String get chatHistory => 'Chatverlauf';

  @override
  String get superChatHistory => 'Super-Chat-Verlauf';

  @override
  String get noChatHistory => 'Kein Chatverlauf';

  @override
  String get noSuperChatHistory => 'Kein Super-Chat-Verlauf';

  @override
  String get streamInfo => 'Stream-Info';

  @override
  String get connectedSince => 'Verbunden seit';

  @override
  String get deleteViewer => 'Zuschauer löschen';

  @override
  String get deleteAllViewers => 'Alle Zuschauer löschen';

  @override
  String get deleteViewerConfirm =>
      'Diesen Zuschauer und alle Nachrichten löschen?';

  @override
  String get deleteAllViewersConfirm =>
      'ALLE Zuschauer und Nachrichten löschen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get scrollToLatest => 'Zum Neuesten';

  @override
  String get backToTop => 'Nach oben';

  @override
  String get deleteChannelData => 'Kanaldaten löschen';

  @override
  String get deleteChannelDataConfirm =>
      'Alle Nachrichten, Super Chats und Stream-Aufzeichnungen dieses Kanals löschen? Zuschauer ohne Nachrichten werden ebenfalls entfernt. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteAllData => 'Alle Daten löschen';

  @override
  String get deleteAllDataConfirm =>
      'ALLE Nachrichten, Super Chats, Zuschauer und Stream-Aufzeichnungen löschen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get membershipTab => 'Mitgliedschaft';

  @override
  String get newMembers => 'Neue Mitglieder';

  @override
  String get giftedMemberships => 'Geschenke';

  @override
  String get milestones => 'Meilensteine';

  @override
  String get newMember => 'Neues Mitglied';

  @override
  String get giftedMembership => 'Geschenk';

  @override
  String get milestone => 'Meilenstein';

  @override
  String get noMembershipEvents => 'Noch keine Mitgliedschaftsereignisse.';

  @override
  String get months => 'Monate';

  @override
  String get gifted => 'geschenkt';

  @override
  String get chatFontSize => 'Chat-Schriftgröße';

  @override
  String get fontSmall => 'Klein';

  @override
  String get fontMedium => 'Mittel';

  @override
  String get fontLarge => 'Groß';

  @override
  String get highlightViewer => 'Markieren';

  @override
  String get removeHighlight => 'Markierung entfernen';

  @override
  String get peakViewers => 'Spitzenzuschauer';
}
