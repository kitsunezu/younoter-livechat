// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => 'Chat';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => 'Tableau de bord';

  @override
  String get settingsTab => 'Paramètres';

  @override
  String get pasteUrlHint => 'Collez l\'URL du direct YouTube ici...';

  @override
  String get connect => 'Connecter';

  @override
  String get disconnect => 'Déconnecter';

  @override
  String get connecting => 'Connexion...';

  @override
  String get connected => 'Connecté';

  @override
  String get disconnected => 'Déconnecté';

  @override
  String get noMessages => 'Aucun message pour l\'instant';

  @override
  String get viewerNote => 'Note du spectateur';

  @override
  String get addNote => 'Ajouter une note';

  @override
  String get editNote => 'Modifier la note';

  @override
  String get saveNote => 'Enregistrer';

  @override
  String get cancelNote => 'Annuler';

  @override
  String get deleteNote => 'Supprimer';

  @override
  String get noteHint => 'Saisissez une note pour ce spectateur...';

  @override
  String get viewerDetails => 'Détails du spectateur';

  @override
  String get displayName => 'Nom affiché';

  @override
  String get handle => 'Handle';

  @override
  String get channelId => 'ID de la chaîne';

  @override
  String get nameHistory => 'Historique des noms';

  @override
  String get totalMessages => 'Total des messages';

  @override
  String get totalSuperChats => 'Total des Super Chats';

  @override
  String get totalAmount => 'Montant total';

  @override
  String get topDonors => 'Principaux donateurs';

  @override
  String get activeViewers => 'Spectateurs actifs';

  @override
  String get markRead => 'Marquer comme lu';

  @override
  String get markProcessed => 'Marquer comme traité';

  @override
  String get unread => 'Non lu';

  @override
  String get read => 'Lu';

  @override
  String get processed => 'Traité';

  @override
  String get filterAll => 'Tous';

  @override
  String get searchHint => 'Rechercher...';

  @override
  String get sortByAmount => 'Par montant';

  @override
  String get sortByTime => 'Par heure';

  @override
  String get sortByStatus => 'Par statut';

  @override
  String get urlHistory => 'Historique des URLs';

  @override
  String get clearHistory => 'Effacer l\'historique';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get alwaysOnTop => 'Toujours au premier plan';

  @override
  String get language => 'Langue';

  @override
  String get amount => 'Montant';

  @override
  String get message => 'Message';

  @override
  String get time => 'Heure';

  @override
  String get viewer => 'Spectateur';

  @override
  String get status => 'Statut';

  @override
  String get invalidUrl => 'URL de direct YouTube invalide';

  @override
  String connectionError(String error) {
    return 'Erreur de connexion : $error';
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
  String get superChatDistribution => 'Répartition des Super Chats';

  @override
  String get currencyDistribution => 'Répartition par devise';

  @override
  String get noSuperChatDonors => 'Aucun donateur Super Chat pour l\'instant.';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get connectToSeeStats =>
      'Connectez-vous à un direct pour voir les statistiques.';

  @override
  String get noteSaved => 'Note enregistrée';

  @override
  String get viewerNotFound => 'Spectateur introuvable';

  @override
  String get firstSeen => 'Première apparition';

  @override
  String get lastSeen => 'Dernière apparition';

  @override
  String get apiKeyOptional => 'Facultatif';

  @override
  String get apiKeyOptionalHint =>
      'Pas besoin de clé API ! L\'app fonctionne sans en récupérant les données publiques du chat. Ajoutez une clé pour des limites de requêtes plus élevées.';

  @override
  String get apiKeyHelp =>
      'Obtenez votre clé API dans Google Cloud Console → APIs & Services → Credentials';

  @override
  String get displayNameMode => 'Mode d\'affichage du nom';

  @override
  String get usernameAndHandle => 'Nom @Handle';

  @override
  String get usernameOnly => 'Nom uniquement';

  @override
  String get handleOnly => '@Handle uniquement';

  @override
  String get counting => 'Décompte...';

  @override
  String get viewerSearchTab => 'Spectateurs';

  @override
  String get searchViewerHint => 'Rechercher par nom ou handle...';

  @override
  String get broadcasterChannel => 'Chaîne du streamer';

  @override
  String get allChannels => 'Toutes les chaînes';

  @override
  String get noViewersFound => 'Aucun spectateur trouvé';

  @override
  String get chatHistory => 'Historique du chat';

  @override
  String get superChatHistory => 'Historique des Super Chats';

  @override
  String get noChatHistory => 'Aucun historique de chat';

  @override
  String get noSuperChatHistory => 'Aucun historique de Super Chat';

  @override
  String get streamInfo => 'Infos du direct';

  @override
  String get connectedSince => 'Connecté depuis';

  @override
  String get deleteViewer => 'Supprimer le spectateur';

  @override
  String get deleteAllViewers => 'Supprimer tous les spectateurs';

  @override
  String get deleteViewerConfirm =>
      'Supprimer ce spectateur et tous ses messages ?';

  @override
  String get deleteAllViewersConfirm =>
      'Supprimer TOUS les spectateurs et leurs messages ? Cette action est irréversible.';

  @override
  String get confirm => 'Confirmer';

  @override
  String get cancel => 'Annuler';

  @override
  String get scrollToLatest => 'Aller au plus récent';

  @override
  String get backToTop => 'Retour en haut';

  @override
  String get deleteChannelData => 'Supprimer les données de la chaîne';

  @override
  String get deleteChannelDataConfirm =>
      'Supprimer tous les messages, Super Chats et enregistrements de directs de cette chaîne ? Les spectateurs sans messages seront également supprimés. Cette action est irréversible.';

  @override
  String get deleteAllData => 'Supprimer toutes les données';

  @override
  String get deleteAllDataConfirm =>
      'Supprimer TOUS les messages, Super Chats, spectateurs et enregistrements de directs ? Cette action est irréversible.';

  @override
  String get membershipTab => 'Abonnement';

  @override
  String get newMembers => 'Nouveaux membres';

  @override
  String get giftedMemberships => 'Offerts';

  @override
  String get milestones => 'Jalons';

  @override
  String get newMember => 'Nouveau membre';

  @override
  String get giftedMembership => 'Offert';

  @override
  String get milestone => 'Jalon';

  @override
  String get noMembershipEvents =>
      'Aucun événement d\'abonnement pour l\'instant.';

  @override
  String get months => 'mois';

  @override
  String get gifted => 'offerts';

  @override
  String get chatFontSize => 'Taille de police du chat';

  @override
  String get fontSmall => 'Petit';

  @override
  String get fontMedium => 'Moyen';

  @override
  String get fontLarge => 'Grand';
}
