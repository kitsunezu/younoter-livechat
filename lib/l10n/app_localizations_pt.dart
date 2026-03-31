// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'YouNoter';

  @override
  String get chatTab => 'Chat';

  @override
  String get superChatTab => 'Super Chat';

  @override
  String get dashboardTab => 'Painel';

  @override
  String get settingsTab => 'Configurações';

  @override
  String get pasteUrlHint => 'Cole a URL da live do YouTube aqui...';

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
  String get noMessages => 'Nenhuma mensagem ainda';

  @override
  String get viewerNote => 'Nota do espectador';

  @override
  String get addNote => 'Adicionar nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get saveNote => 'Salvar';

  @override
  String get cancelNote => 'Cancelar';

  @override
  String get deleteNote => 'Excluir';

  @override
  String get noteHint => 'Digite uma nota para este espectador...';

  @override
  String get viewerDetails => 'Detalhes do espectador';

  @override
  String get displayName => 'Nome de exibição';

  @override
  String get handle => 'Handle';

  @override
  String get channelId => 'ID do canal';

  @override
  String get nameHistory => 'Histórico de nomes';

  @override
  String get totalMessages => 'Total de mensagens';

  @override
  String get totalSuperChats => 'Total de Super Chats';

  @override
  String get totalAmount => 'Valor total';

  @override
  String get topDonors => 'Principais doadores';

  @override
  String get activeViewers => 'Espectadores ativos';

  @override
  String get markRead => 'Marcar como lido';

  @override
  String get markProcessed => 'Marcar como processado';

  @override
  String get unread => 'Não lido';

  @override
  String get read => 'Lido';

  @override
  String get processed => 'Processado';

  @override
  String get filterAll => 'Todos';

  @override
  String get searchHint => 'Pesquisar...';

  @override
  String get sortByAmount => 'Por valor';

  @override
  String get sortByTime => 'Por horário';

  @override
  String get sortByStatus => 'Por status';

  @override
  String get urlHistory => 'Histórico de URLs';

  @override
  String get clearHistory => 'Limpar histórico';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get alwaysOnTop => 'Sempre no topo';

  @override
  String get language => 'Idioma';

  @override
  String get amount => 'Valor';

  @override
  String get message => 'Mensagem';

  @override
  String get time => 'Horário';

  @override
  String get viewer => 'Espectador';

  @override
  String get status => 'Status';

  @override
  String get invalidUrl => 'URL de live do YouTube inválida';

  @override
  String connectionError(String error) {
    return 'Erro de conexão: $error';
  }

  @override
  String chatCount(int count) {
    return '$count mensagens';
  }

  @override
  String superChatCount(int count) {
    return '$count Super Chats';
  }

  @override
  String get superChatDistribution => 'Distribuição de Super Chat';

  @override
  String get currencyDistribution => 'Distribuição por moeda';

  @override
  String get noSuperChatDonors => 'Nenhum doador de Super Chat ainda.';

  @override
  String get noData => 'Sem dados';

  @override
  String get connectToSeeStats =>
      'Conecte-se a uma live para ver as estatísticas.';

  @override
  String get noteSaved => 'Nota salva';

  @override
  String get viewerNotFound => 'Espectador não encontrado';

  @override
  String get firstSeen => 'Primeira vez';

  @override
  String get lastSeen => 'Última vez';

  @override
  String get apiKeyOptional => 'Opcional';

  @override
  String get apiKeyOptionalHint =>
      'Não é necessário API Key! O app funciona sem ela coletando dados públicos do chat. Adicione uma chave para limites de requisição maiores.';

  @override
  String get apiKeyHelp =>
      'Obtenha sua API Key em Google Cloud Console → APIs & Services → Credentials';

  @override
  String get displayNameMode => 'Modo de exibição do nome';

  @override
  String get usernameAndHandle => 'Nome @Handle';

  @override
  String get usernameOnly => 'Apenas nome';

  @override
  String get handleOnly => 'Apenas @Handle';

  @override
  String get counting => 'Contando...';

  @override
  String get viewerSearchTab => 'Espectadores';

  @override
  String get searchViewerHint => 'Pesquisar por nome ou handle...';

  @override
  String get broadcasterChannel => 'Canal do streamer';

  @override
  String get allChannels => 'Todos os canais';

  @override
  String get noViewersFound => 'Nenhum espectador encontrado';

  @override
  String get chatHistory => 'Histórico de chat';

  @override
  String get superChatHistory => 'Histórico de Super Chat';

  @override
  String get noChatHistory => 'Sem histórico de chat';

  @override
  String get noSuperChatHistory => 'Sem histórico de Super Chat';

  @override
  String get streamInfo => 'Info da live';

  @override
  String get connectedSince => 'Conectado desde';

  @override
  String get deleteViewer => 'Excluir espectador';

  @override
  String get deleteAllViewers => 'Excluir todos os espectadores';

  @override
  String get deleteViewerConfirm =>
      'Excluir este espectador e todas as mensagens?';

  @override
  String get deleteAllViewersConfirm =>
      'Excluir TODOS os espectadores e mensagens? Esta ação não pode ser desfeita.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get scrollToLatest => 'Ir para o mais recente';

  @override
  String get backToTop => 'Voltar ao topo';

  @override
  String get deleteChannelData => 'Excluir dados do canal';

  @override
  String get deleteChannelDataConfirm =>
      'Excluir todas as mensagens, Super Chats e registros de lives deste canal? Espectadores sem mensagens também serão removidos. Esta ação não pode ser desfeita.';

  @override
  String get deleteAllData => 'Excluir todos os dados';

  @override
  String get deleteAllDataConfirm =>
      'Excluir TODAS as mensagens, Super Chats, espectadores e registros de lives? Esta ação não pode ser desfeita.';

  @override
  String get membershipTab => 'Assinatura';

  @override
  String get newMembers => 'Novos membros';

  @override
  String get giftedMemberships => 'Presentes';

  @override
  String get milestones => 'Marcos';

  @override
  String get newMember => 'Novo membro';

  @override
  String get giftedMembership => 'Presente';

  @override
  String get milestone => 'Marco';

  @override
  String get noMembershipEvents => 'Nenhum evento de assinatura ainda.';

  @override
  String get months => 'meses';

  @override
  String get gifted => 'presentes';

  @override
  String get chatFontSize => 'Tamanho da fonte do chat';

  @override
  String get fontSmall => 'Pequeno';

  @override
  String get fontMedium => 'Médio';

  @override
  String get fontLarge => 'Grande';
}
