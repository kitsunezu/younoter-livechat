import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/providers/providers.dart';
import '../../core/youtube/currency_utils.dart';
import '../../core/youtube/live_chat_manager.dart';
import '../../l10n/app_localizations.dart';
import '../viewers/viewer_detail_panel.dart';
import 'chat_message_text.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _urlController = TextEditingController();
  final _scrollController = ScrollController();
  bool _atBottom = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final atBottom = _scrollController.offset <= 8;
      if (atBottom != _atBottom) setState(() => _atBottom = atBottom);
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final manager = ref.read(liveChatManagerProvider);
    await manager.connect(_urlController.text);
  }

  void _disconnect() {
    ref.read(liveChatManagerProvider).disconnect();
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(chatStatusProvider);
    final status = statusAsync.valueOrNull ?? ChatConnectionStatus.disconnected;
    final manager = ref.watch(liveChatManagerProvider);
    final selectedViewerId = ref.watch(selectedViewerIdProvider);
    final liveChatId = manager.liveChatId;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    // On mobile, show bottom sheet when viewer is selected
    ref.listen<String?>(selectedViewerIdProvider, (prev, next) {
      if (next != null && !isWide) {
        final container = ProviderScope.containerOf(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) => UncontrolledProviderScope(
            container: container,
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.85,
              expand: false,
              builder: (ctx, scrollController) => ViewerDetailPanel(
                channelId: next,
                scrollController: scrollController,
              ),
            ),
          ),
        ).whenComplete(() {
          ref.read(selectedViewerIdProvider.notifier).state = null;
        });
      }
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main chat area
        Expanded(
          flex: 3,
          child: Column(
            children: [
              // Connection bar
              _ConnectionBar(
                controller: _urlController,
                status: status,
                errorMessage: manager.errorMessage,
                onConnect: _connect,
                onDisconnect: _disconnect,
              ),
              // Messages list
              Expanded(
                child: liveChatId == null
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.pasteUrlHint,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          _ChatMessageList(
                            liveChatId: liveChatId,
                            ownerChannelId:
                                manager.currentOwnerChannelId ?? '',
                            scrollController: _scrollController,
                          ),
                          if (!_atBottom)
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: FloatingActionButton.small(
                                onPressed: () =>
                                    _scrollController.animateTo(
                                  0,
                                  duration:
                                      const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                ),
                                tooltip: AppLocalizations.of(context)!
                                    .scrollToLatest,
                                child: const Icon(
                                    Icons.keyboard_double_arrow_down),
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        // Viewer detail side panel (desktop only)
        if (selectedViewerId != null && isWide) ...[
          const VerticalDivider(width: 1),
          SizedBox(
            width: 320,
            child: ViewerDetailPanel(channelId: selectedViewerId),
          ),
        ],
      ],
    );
  }
}

/// The connection URL bar at the top.
class _ConnectionBar extends StatelessWidget {
  final TextEditingController controller;
  final ChatConnectionStatus status;
  final String? errorMessage;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  const _ConnectionBar({
    required this.controller,
    required this.status,
    this.errorMessage,
    required this.onConnect,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = status == ChatConnectionStatus.connected;
    final isConnecting = status == ChatConnectionStatus.connecting;
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: !isConnected && !isConnecting,
                  decoration: InputDecoration(
                    hintText: l.pasteUrlHint,
                    prefixIcon: const Icon(Icons.link),
                    border: const OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: _StatusIndicator(status: status),
                  ),
                  onSubmitted: (_) => onConnect(),
                ),
              ),
              const SizedBox(width: 8),
              if (isConnected)
                FilledButton.tonalIcon(
                  onPressed: onDisconnect,
                  icon: const Icon(Icons.stop),
                  label: Text(l.disconnect),
                )
              else
                FilledButton.icon(
                  onPressed: isConnecting ? null : onConnect,
                  icon: isConnecting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow),
                  label: Text(isConnecting ? l.connecting : l.connect),
                ),
            ],
          ),
          if (status == ChatConnectionStatus.error && errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorMessage!,
                style: TextStyle(color: colorScheme.error, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final ChatConnectionStatus status;
  const _StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final (color, tooltip) = switch (status) {
      ChatConnectionStatus.disconnected => (Colors.grey, l.disconnected),
      ChatConnectionStatus.connecting => (Colors.orange, l.connecting),
      ChatConnectionStatus.connected => (Colors.green, l.connected),
      ChatConnectionStatus.error => (Colors.red, 'Error'),
    };

    return Tooltip(
      message: tooltip,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: CircleAvatar(radius: 5, backgroundColor: color),
      ),
    );
  }
}

/// Displays the list of chat messages streamed from the database.
class _ChatMessageList extends ConsumerWidget {
  final String liveChatId;
  final String ownerChannelId;
  final ScrollController scrollController;

  const _ChatMessageList({
    required this.liveChatId,
    required this.ownerChannelId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatMessagesProvider(liveChatId));
    final viewersMap =
        ref.watch(chatViewersMapProvider(liveChatId)).valueOrNull ?? {};
    final firstTimers =
        ref.watch(firstTimeViewersProvider(liveChatId)).valueOrNull ?? {};
    final mode = ref.watch(displayNameModeProvider);
    final fontSize = ref.watch(chatFontSizeProvider);
    final membershipsMap =
        ref.watch(membershipsByIdProvider(liveChatId)).valueOrNull ?? {};
    final superChatsMap =
        ref.watch(superChatsByIdProvider(liveChatId)).valueOrNull ?? {};
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;

    return messagesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (messages) {
        if (messages.isEmpty) {
          return Center(
            child: Text(
              l.noMessages,
              style: theme.textTheme.bodyLarge,
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          reverse: true,
          itemCount: messages.length,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          itemBuilder: (context, index) {
            final msg = messages[index];
            final isSuperChat = msg.type == 'superChatEvent' ||
                msg.type == 'superStickerEvent';
            final viewer = viewersMap[msg.channelId];

            return _ChatMessageTile(
              message: msg,
              viewer: viewer,
              membership: membershipsMap[msg.id],
              superChat: superChatsMap[msg.id],
              isFirstTime: firstTimers.contains(msg.channelId),
              displayNameMode: mode,
              chatFontSize: fontSize,
              isSuperChat: isSuperChat,
              onTapViewer: () {
                ref.read(selectedOwnerChannelIdProvider.notifier).state =
                  ownerChannelId;
                ref.read(selectedViewerIdProvider.notifier).state =
                    msg.channelId;
              },
            );
          },
        );
      },
    );
  }
}

class _ChatMessageTile extends StatelessWidget {
  final dynamic message; // ChatMessage from drift
  final dynamic viewer; // Viewer? from drift
  final Membership? membership;
  final SuperChat? superChat;
  final bool isFirstTime;
  final DisplayNameMode displayNameMode;
  final ChatFontSize chatFontSize;
  final bool isSuperChat;
  final VoidCallback onTapViewer;

  const _ChatMessageTile({
    required this.message,
    this.viewer,
    this.membership,
    this.superChat,
    required this.isFirstTime,
    required this.displayNameMode,
    required this.chatFontSize,
    required this.isSuperChat,
    required this.onTapViewer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final handle = viewer?.handle as String?;
    final username = viewer?.username as String?;
    final viewerName = (username != null && username.isNotEmpty)
        ? username
        : (viewer?.displayName as String? ?? message.displayName);

    final double fontSizeValue = switch (chatFontSize) {
      ChatFontSize.small => 12.0,
      ChatFontSize.medium => 14.0,
      ChatFontSize.large => 17.0,
    };
    final bodyStyle =
        theme.textTheme.bodyMedium?.copyWith(fontSize: fontSizeValue);

    final String displayLabel;
    switch (displayNameMode) {
      case DisplayNameMode.usernameOnly:
        displayLabel = viewerName;
      case DisplayNameMode.handleOnly:
        displayLabel = (handle != null && handle.isNotEmpty)
            ? '@$handle'
            : viewerName;
      case DisplayNameMode.usernameAndHandle:
        if (handle != null && handle.isNotEmpty) {
          // If handle equals display name (with or without @), just show @handle
          if (handle == viewerName || '@$handle' == viewerName) {
            displayLabel = '@$handle';
          } else {
            displayLabel = '$viewerName (@$handle)';
          }
        } else {
          displayLabel = viewerName;
        }
    }

    final bool isMembershipEvent = message.type == 'newSponsorEvent' ||
        message.type == 'membershipGiftingEvent' ||
        message.type == 'memberMilestoneChatEvent';

    final Color? scBg = isSuperChat && superChat != null
        ? _ytTierColor(superChat!.amountMicros, superChat!.currency,
            isSticker: message.type == 'superStickerEvent')
        : null;
    final Color? scBorder = isSuperChat && superChat != null
        ? _ytTierBorderColor(superChat!.amountMicros, superChat!.currency,
            isSticker: message.type == 'superStickerEvent')
        : null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: isSuperChat
          ? BoxDecoration(
              color: scBg ?? Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: scBorder ?? Colors.amber.withValues(alpha: 0.4)),
            )
          : isMembershipEvent
              ? BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.green.withValues(alpha: 0.4)),
                )
              : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Viewer name (clickable) + first-time badge
          GestureDetector(
            onTap: onTapViewer,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isFirstTime)
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0000),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'NEW',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Flexible(
                    child: Text(
                      displayLabel,
                      style: bodyStyle?.copyWith(
                        color: message.isMember
                            ? Colors.green
                            : colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Membership event badge or message text
          if (isSuperChat && superChat != null)
            _SuperChatAmountBadge(superChat: superChat!)
          else if (isMembershipEvent)
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.card_membership, size: 14,
                      color: Colors.green.shade700),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _membershipLabel(message.type),
                          style: bodyStyle?.copyWith(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (membership != null) ...[
                          _MembershipSubtitle(
                            months: membership!.milestoneMonths,
                            level: membership!.membershipLevel,
                            context: context,
                          ),
                        ],
                        if (message.messageText.isNotEmpty)
                          ChatMessageText(
                            message.messageText,
                            style: bodyStyle?.copyWith(
                              color: Colors.green.shade700,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ChatMessageText(
                message.messageText,
                style: bodyStyle,
              ),
            ),
          // Timestamp
          Text(
            _formatTime(message.publishedAt),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  /// YouTube Super Chat tier colors (background, ~20% opacity).
  static Color _ytTierColor(int amountMicros, String currency,
      {bool isSticker = false}) {
    return _ytTierBase(amountMicros, currency, isSticker: isSticker)
        .withValues(alpha: 0.18);
  }

  static Color _ytTierBorderColor(int amountMicros, String currency,
      {bool isSticker = false}) {
    return _ytTierBase(amountMicros, currency, isSticker: isSticker)
        .withValues(alpha: 0.55);
  }

  static Color _ytTierBase(int amountMicros, String currency,
      {bool isSticker = false}) {
    if (isSticker) return const Color(0xFF00BFA5); // teal for stickers
    final usd = normalizeToUsd(currency, amountMicros);
    if (usd >= 100) return const Color(0xFFE62117);   // Red
    if (usd >= 50)  return const Color(0xFFE91E63);   // Magenta
    if (usd >= 20)  return const Color(0xFFE65100);   // Orange
    if (usd >= 10)  return const Color(0xFFFFD600);   // Yellow
    if (usd >= 5)   return const Color(0xFF00BFA5);   // Teal
    if (usd >= 2)   return const Color(0xFF1E88E5);   // Blue
    return const Color(0xFF1565C0);                   // Light blue
  }

  String _membershipLabel(String type) {
    return switch (type) {
      'newSponsorEvent' => 'New Member',
      'membershipGiftingEvent' => 'Gifted Membership',
      'memberMilestoneChatEvent' => 'Milestone',
      _ => type,
    };
  }
}

/// Displays the Super Chat / Super Sticker amount badge and message text
/// inside a chat tile. The widget expands to fill available row space.
class _SuperChatAmountBadge extends StatelessWidget {
  final SuperChat superChat;

  const _SuperChatAmountBadge({required this.superChat});

  @override
  Widget build(BuildContext context) {
    final isSticker = superChat.type == 'superStickerEvent';
    final base = _ChatMessageTile._ytTierBase(
      superChat.amountMicros,
      superChat.currency,
      isSticker: isSticker,
    );
    final amountText =
        formatCurrencyAmount(superChat.currency, superChat.amountMicros);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Amount pill
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: base.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              amountText,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(color: Colors.black38, blurRadius: 2)
                    ],
                  ),
            ),
          ),
          // Message / sticker (if any)
          if (superChat.messageText.isNotEmpty) ...[
            const SizedBox(height: 2),
            ChatMessageText(
              superChat.messageText,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              imageSize: superChat.type == 'superStickerEvent' ? 96.0 : null,
            ),
          ],
        ],
      ),
    );
  }
}

/// Small subtitle showing membership months and/or level for chat tile.
class _MembershipSubtitle extends StatelessWidget {
  final int months;
  final String level;
  final BuildContext context;

  const _MembershipSubtitle({
    required this.months,
    required this.level,
    required this.context,
  });

  @override
  Widget build(BuildContext _) {
    final l = AppLocalizations.of(context)!;
    final parts = <String>[];
    if (months > 0) parts.add('$months ${l.months}');
    if (level.isNotEmpty) parts.add(level);
    if (parts.isEmpty) return const SizedBox.shrink();
    return Text(
      parts.join(' • '),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.green.shade600,
      ),
    );
  }
}
