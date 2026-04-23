import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/providers/providers.dart';
import '../../l10n/app_localizations.dart';
import 'chat_message_text.dart';

class ChatSearchPanel extends ConsumerStatefulWidget {
  final String liveChatId;
  final VoidCallback onClose;
  final bool compactLayout;
  final GestureDragStartCallback? onDragStart;
  final GestureDragUpdateCallback? onDragUpdate;
  final GestureDragEndCallback? onDragEnd;
  final GestureDragCancelCallback? onDragCancel;

  const ChatSearchPanel({
    super.key,
    required this.liveChatId,
    required this.onClose,
    this.compactLayout = false,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onDragCancel,
  });

  @override
  ConsumerState<ChatSearchPanel> createState() => _ChatSearchPanelState();
}

class _ChatSearchPanelState extends ConsumerState<ChatSearchPanel> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(chatMessageSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleRead(String messageId, bool isRead) {
    ref.read(chatSearchReadMessageIdsProvider.notifier).update((current) {
      final updated = Set<String>.from(current);
      if (isRead) {
        updated.remove(messageId);
      } else {
        updated.add(messageId);
      }
      return updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final activeLiveChatId = ref.watch(liveChatIdProvider);
    final resultsAsync = ref.watch(chatSearchResultsProvider(widget.liveChatId));
    final filter = ref.watch(chatSearchFilterProvider);
    final readMessageIds = ref.watch(chatSearchReadMessageIdsProvider);
    final viewersMap =
        ref.watch(chatViewersMapProvider(widget.liveChatId)).valueOrNull ?? {};
    final displayNameMode = ref.watch(displayNameModeProvider);
    final theme = Theme.of(context);

    if (activeLiveChatId != widget.liveChatId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        widget.onClose();
      });
      return const SizedBox.shrink();
    }

    final panelBorderRadius = widget.compactLayout
        ? const BorderRadius.vertical(top: Radius.circular(28))
        : BorderRadius.circular(20);
    final headerPadding = EdgeInsets.fromLTRB(
      widget.compactLayout ? 16 : 20,
      widget.compactLayout ? 10 : 18,
      12,
      8,
    );
    final contentPadding = EdgeInsets.fromLTRB(
      widget.compactLayout ? 16 : 20,
      0,
      widget.compactLayout ? 16 : 20,
      10,
    );

    return Material(
      elevation: widget.compactLayout ? 16 : 12,
      color: widget.compactLayout
          ? theme.colorScheme.surface
          : theme.colorScheme.surfaceContainerHigh,
      borderRadius: panelBorderRadius,
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.compactLayout)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: widget.onDragStart,
                onVerticalDragUpdate: widget.onDragUpdate,
                onVerticalDragEnd: widget.onDragEnd,
                onVerticalDragCancel: widget.onDragCancel,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 2),
                  child: SizedBox(
                    height: 28,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: headerPadding,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l.searchMessages,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                    onPressed: widget.onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Padding(
              padding: contentPadding,
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  isDense: true,
                  filled: widget.compactLayout,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          tooltip:
                              MaterialLocalizations.of(context).clearButtonTooltip,
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(chatMessageSearchQueryProvider.notifier)
                                .state = '';
                            setState(() {});
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
                onChanged: (value) {
                  ref.read(chatMessageSearchQueryProvider.notifier).state = value;
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: contentPadding.copyWith(bottom: widget.compactLayout ? 12 : 10),
              child: widget.compactLayout
                  ? SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ChatSearchFilter.values
                            .map(
                              (value) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  selected: filter == value,
                                  label: Text(_chatSearchFilterLabel(value, l)),
                                  onSelected: (_) {
                                    ref
                                        .read(chatSearchFilterProvider.notifier)
                                        .state = value;
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ChatSearchFilter.values
                          .map(
                            (value) => FilterChip(
                              selected: filter == value,
                              label: Text(_chatSearchFilterLabel(value, l)),
                              onSelected: (_) {
                                ref.read(chatSearchFilterProvider.notifier).state =
                                    value;
                              },
                            ),
                          )
                          .toList(),
                    ),
            ),
            const Divider(height: 1),
            Expanded(
              child: resultsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (result) {
                  if (result.allMessages.isEmpty) {
                    return _ChatSearchEmptyState(message: l.noMessages);
                  }

                  if (result.visibleMessages.isEmpty) {
                    return _ChatSearchEmptyState(
                      message: l.noMatchingMessages,
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(widget.compactLayout ? 10 : 12),
                    itemCount: result.visibleMessages.length,
                    itemBuilder: (context, index) {
                      final message = result.visibleMessages[index];
                      final viewer = viewersMap[message.channelId];
                      final isRead = readMessageIds.contains(message.id);

                      return _ChatSearchResultTile(
                        message: message,
                        viewer: viewer,
                        displayNameMode: displayNameMode,
                        isRead: isRead,
                        onToggleRead: () => _toggleRead(message.id, isRead),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatSearchEmptyState extends StatelessWidget {
  final String message;

  const _ChatSearchEmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        message,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}

class _ChatSearchResultTile extends StatelessWidget {
  final ChatMessage message;
  final Viewer? viewer;
  final DisplayNameMode displayNameMode;
  final bool isRead;
  final VoidCallback onToggleRead;

  const _ChatSearchResultTile({
    required this.message,
    required this.viewer,
    required this.displayNameMode,
    required this.isRead,
    required this.onToggleRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final accentColor = _messageAccentColor(colorScheme);
    final statusIcon = isRead
        ? Icons.mark_email_read_rounded
        : Icons.mark_email_unread_rounded;
    final statusLabel = isRead ? l.read : l.unread;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: accentColor.withValues(alpha: isRead ? 0.08 : 0.16),
      child: InkWell(
        onTap: isRead ? null : onToggleRead,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayLabel(message, viewer, displayNameMode),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(message.publishedAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ActionChip(
                    avatar: Icon(
                      statusIcon,
                      size: 16,
                      color: isRead ? Colors.blue : Colors.orange,
                    ),
                    label: Text(statusLabel),
                    tooltip: isRead ? l.markUnread : l.markRead,
                    onPressed: onToggleRead,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (message.messageText.isNotEmpty)
                ChatMessageText(message.messageText, selectable: true)
              else
                Text(
                  message.type,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _messageAccentColor(ColorScheme colorScheme) {
    if (message.type == 'superChatEvent' ||
        message.type == 'superStickerEvent') {
      return Colors.amber.shade800;
    }

    if (message.type == 'newSponsorEvent' ||
        message.type == 'membershipGiftingEvent' ||
        message.type == 'memberMilestoneChatEvent') {
      return Colors.green.shade700;
    }

    return colorScheme.primary;
  }
}

String _chatSearchFilterLabel(ChatSearchFilter filter, AppLocalizations l) {
  return switch (filter) {
    ChatSearchFilter.all => l.filterAll,
    ChatSearchFilter.unread => l.unread,
    ChatSearchFilter.read => l.read,
  };
}

String _displayLabel(
  ChatMessage message,
  Viewer? viewer,
  DisplayNameMode displayNameMode,
) {
  final handle = viewer?.handle;
  final username = viewer?.username;
  final viewerName = (username != null && username.isNotEmpty)
      ? username
      : (viewer?.displayName ?? message.displayName);

  return switch (displayNameMode) {
    DisplayNameMode.usernameOnly => viewerName,
    DisplayNameMode.handleOnly =>
      (handle != null && handle.isNotEmpty) ? '@$handle' : viewerName,
    DisplayNameMode.usernameAndHandle =>
      (handle != null && handle.isNotEmpty)
          ? (handle == viewerName || '@$handle' == viewerName)
              ? '@$handle'
              : '$viewerName (@$handle)'
          : viewerName,
  };
}

String _formatDateTime(DateTime dt) {
  return '${dt.month}/${dt.day} '
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}