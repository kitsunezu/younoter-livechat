// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => 'Chat';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => 'Panel';

  @override
  String get settingsTab => 'Ajustes';

  @override
  String get pasteUrlHint => 'Pega la URL del directo de YouTube aquí...';

  @override
  String get connect => 'Conectar';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get connecting => 'Conectando...';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get noMessages => 'Aún no hay mensajes';

  @override
  String get viewerNote => 'Nota del espectador';

  @override
  String get addNote => 'Añadir nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get saveNote => 'Guardar';

  @override
  String get cancelNote => 'Cancelar';

  @override
  String get deleteNote => 'Eliminar';

  @override
  String get noteHint => 'Escribe una nota para este espectador...';

  @override
  String get viewerDetails => 'Detalles del espectador';

  @override
  String get displayName => 'Nombre';

  @override
  String get handle => 'Handle';

  @override
  String get channelId => 'ID del canal';

  @override
  String get nameHistory => 'Historial de nombres';

  @override
  String get totalMessages => 'Total de mensajes';

  @override
  String get totalSuperChats => 'Total de Super Chats';

  @override
  String get totalAmount => 'Monto total';

  @override
  String get topDonors => 'Principales donantes';

  @override
  String get top5Donors => 'Top 5 donantes';

  @override
  String get activeViewers => 'Espectadores activos';

  @override
  String get markRead => 'Marcar como leído';

  @override
  String get markProcessed => 'Marcar como procesado';

  @override
  String get unread => 'No leído';

  @override
  String get read => 'Leído';

  @override
  String get processed => 'Procesado';

  @override
  String get filterAll => 'Todos';

  @override
  String get searchHint => 'Buscar...';

  @override
  String get searchMessages => 'Buscar mensajes';

  @override
  String get noMatchingMessages => 'No hay mensajes coincidentes';

  @override
  String get markUnread => 'Marcar como no leído';

  @override
  String get sortByAmount => 'Por monto';

  @override
  String get sortByTime => 'Por hora';

  @override
  String get sortByStatus => 'Por estado';

  @override
  String get urlHistory => 'Historial de URLs';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get alwaysOnTop => 'Siempre visible';

  @override
  String get language => 'Idioma';

  @override
  String get amount => 'Monto';

  @override
  String get message => 'Mensaje';

  @override
  String get time => 'Hora';

  @override
  String get viewer => 'Espectador';

  @override
  String get status => 'Estado';

  @override
  String get invalidUrl => 'URL de directo de YouTube no válida';

  @override
  String connectionError(String error) {
    return 'Error de conexión: $error';
  }

  @override
  String chatCount(int count) {
    return '$count mensajes';
  }

  @override
  String superChatCount(int count) {
    return '$count Super Chats';
  }

  @override
  String get superChatDistribution => 'Distribución de Super Chat';

  @override
  String get currencyDistribution => 'Distribución por moneda';

  @override
  String get noSuperChatDonors => 'Aún no hay donantes de Super Chat.';

  @override
  String get noData => 'Sin datos';

  @override
  String get connectToSeeStats =>
      'Conéctate a un directo para ver las estadísticas.';

  @override
  String get noteSaved => 'Nota guardada';

  @override
  String get viewerNotFound => 'Espectador no encontrado';

  @override
  String get firstSeen => 'Primera vez';

  @override
  String get lastSeen => 'Última vez';

  @override
  String get apiKeyOptional => 'Opcional';

  @override
  String get apiKeyOptionalHint =>
      '¡No se necesita API Key! La app funciona sin ella obteniendo datos del chat público. Añade una clave para mayores límites de solicitudes.';

  @override
  String get apiKeyHelp =>
      'Obtén tu API Key en Google Cloud Console → APIs & Services → Credentials';

  @override
  String get displayNameMode => 'Modo de nombre';

  @override
  String get usernameAndHandle => 'Nombre @Handle';

  @override
  String get usernameOnly => 'Solo nombre';

  @override
  String get handleOnly => 'Solo @Handle';

  @override
  String get counting => 'Contando...';

  @override
  String get viewerSearchTab => 'Espectadores';

  @override
  String get searchViewerHint => 'Buscar por nombre o handle...';

  @override
  String get broadcasterChannel => 'Canal del streamer';

  @override
  String get allChannels => 'Todos los canales';

  @override
  String get noViewersFound => 'No se encontraron espectadores';

  @override
  String get chatHistory => 'Historial de chat';

  @override
  String get superChatHistory => 'Historial de Super Chat';

  @override
  String get noChatHistory => 'Sin historial de chat';

  @override
  String get noSuperChatHistory => 'Sin historial de Super Chat';

  @override
  String get streamInfo => 'Info del directo';

  @override
  String get connectedSince => 'Conectado desde';

  @override
  String get deleteViewer => 'Eliminar espectador';

  @override
  String get deleteAllViewers => 'Eliminar todos los espectadores';

  @override
  String get deleteViewerConfirm =>
      '¿Eliminar este espectador y todos sus mensajes?';

  @override
  String get deleteAllViewersConfirm =>
      '¿Eliminar TODOS los espectadores y sus mensajes? Esta acción no se puede deshacer.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get scrollToLatest => 'Ir al más reciente';

  @override
  String get backToTop => 'Volver arriba';

  @override
  String get deleteChannelData => 'Eliminar datos del canal';

  @override
  String get deleteChannelDataConfirm =>
      '¿Eliminar todos los mensajes, Super Chats y registros de directos de este canal? Los espectadores sin mensajes también serán eliminados. Esta acción no se puede deshacer.';

  @override
  String get deleteAllData => 'Eliminar todos los datos';

  @override
  String get deleteAllDataConfirm =>
      '¿Eliminar TODOS los mensajes, Super Chats, espectadores y registros de directos? Esta acción no se puede deshacer.';

  @override
  String get membershipTab => 'Membresía';

  @override
  String get newMembers => 'Nuevos miembros';

  @override
  String get giftedMemberships => 'Regalados';

  @override
  String get milestones => 'Hitos';

  @override
  String get newMember => 'Nuevo miembro';

  @override
  String get giftedMembership => 'Regalo';

  @override
  String get milestone => 'Hito';

  @override
  String get noMembershipEvents => 'Aún no hay eventos de membresía.';

  @override
  String get months => 'meses';

  @override
  String get gifted => 'regalados';

  @override
  String get chatFontSize => 'Tamaño de fuente del chat';

  @override
  String get fontSmall => 'Pequeño';

  @override
  String get fontMedium => 'Mediano';

  @override
  String get fontLarge => 'Grande';

  @override
  String get highlightViewer => 'Destacar';

  @override
  String get removeHighlight => 'Quitar destaque';

  @override
  String get peakViewers => 'Espectadores pico';
}
