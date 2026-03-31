import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/providers/providers.dart';
import '../../core/youtube/currency_utils.dart';
import '../../l10n/app_localizations.dart';
import '../chat/chat_message_text.dart';
import '../viewers/viewer_detail_panel.dart';

class SuperChatPage extends ConsumerWidget {
  const SuperChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(liveChatManagerProvider);
    final liveChatId = manager.liveChatId;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (liveChatId == null) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noMessages,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final superChatsAsync = ref.watch(superChatsProvider(liveChatId));
    final viewersMap = ref.watch(chatViewersMapProvider(liveChatId)).valueOrNull ?? {};
    final filter = ref.watch(superChatFilterProvider);
    final sort = ref.watch(superChatSortProvider);
    final search = ref.watch(superChatSearchProvider);

    return Column(
      children: [
        // Toolbar
        _SuperChatToolbar(
          filter: filter,
          sort: sort,
          search: search,
        ),
        const Divider(height: 1),
        // List
        Expanded(
          child: superChatsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (superChats) {
              var filtered = _applyFilter(superChats, filter);
              filtered = _applySearch(filtered, search);
              filtered = _applySort(filtered, sort);

              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.noMessages,
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }

              return ListView.builder(
                itemCount: filtered.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final sc = filtered[index];
                  final viewer = viewersMap[sc.channelId];
                  final resolvedName = (viewer?.username?.isNotEmpty ?? false)
                      ? viewer!.username!
                      : sc.displayName;
                  return _SuperChatTile(
                    superChat: sc,
                    resolvedName: resolvedName,
                    onStatusChange: (newStatus) {
                      ref
                          .read(databaseProvider)
                          .superChatDao
                          .updateStatus(sc.id, newStatus);
                    },
                    onTapViewer: () =>
                        _openViewerSheet(context, sc.channelId),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<SuperChat> _applyFilter(
      List<SuperChat> list, SuperChatFilter filter) {
    return switch (filter) {
      SuperChatFilter.all => list,
      SuperChatFilter.unread =>
        list.where((sc) => sc.status == 'unread').toList(),
      SuperChatFilter.read => list.where((sc) => sc.status == 'read').toList(),
    };
  }

  List<SuperChat> _applySearch(List<SuperChat> list, String query) {
    if (query.isEmpty) return list;
    final q = query.toLowerCase();
    return list
        .where((sc) =>
            sc.displayName.toLowerCase().contains(q) ||
            sc.messageText.toLowerCase().contains(q))
        .toList();
  }

  List<SuperChat> _applySort(List<SuperChat> list, SuperChatSort sort) {
    final sorted = List<SuperChat>.from(list);
    switch (sort) {
      case SuperChatSort.time:
        sorted.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      case SuperChatSort.amount:
        sorted.sort((a, b) => normalizeToUsd(b.currency, b.amountMicros)
            .compareTo(normalizeToUsd(a.currency, a.amountMicros)));
      case SuperChatSort.status:
        const order = {'unread': 0, 'read': 1};
        sorted.sort((a, b) =>
            (order[a.status] ?? 1).compareTo(order[b.status] ?? 1));
    }
    return sorted;
  }
}

void _openViewerSheet(BuildContext ctx, String channelId) {
  final container = ProviderScope.containerOf(ctx);
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => UncontrolledProviderScope(
      container: container,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        expand: false,
        builder: (c, sc) => ViewerDetailPanel(
          channelId: channelId,
          scrollController: sc,
        ),
      ),
    ),
  );
}

class _SuperChatToolbar extends ConsumerWidget {
  final SuperChatFilter filter;
  final SuperChatSort sort;
  final String search;

  const _SuperChatToolbar({
    required this.filter,
    required this.sort,
    required this.search,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: filter chips + search
          Row(
            children: [
              ...SuperChatFilter.values.map((f) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: FilterChip(
                      selected: filter == f,
                      label: Text(
                        _filterLabel(f, l),
                        style: theme.textTheme.labelMedium,
                      ),
                      visualDensity: VisualDensity.compact,
                      onSelected: (_) =>
                          ref.read(superChatFilterProvider.notifier).state = f,
                    ),
                  )),
              const Spacer(),
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: l.searchHint,
                    prefixIcon: const Icon(Icons.search, size: 18),
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                  ),
                  onChanged: (v) =>
                      ref.read(superChatSearchProvider.notifier).state = v,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 2: sort segmented button
          Row(
            children: [
              Icon(
                Icons.sort_rounded,
                size: 17,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              SegmentedButton<SuperChatSort>(
                segments: [
                  ButtonSegment(
                    value: SuperChatSort.time,
                    icon: const Icon(Icons.access_time_rounded, size: 15),
                    label: Text(l.time),
                  ),
                  ButtonSegment(
                    value: SuperChatSort.amount,
                    icon: const Icon(Icons.attach_money_rounded, size: 15),
                    label: Text(l.amount),
                  ),
                  ButtonSegment(
                    value: SuperChatSort.status,
                    icon: const Icon(Icons.flag_outlined, size: 15),
                    label: Text(l.status),
                  ),
                ],
                selected: {sort},
                onSelectionChanged: (set) {
                  if (set.isNotEmpty) {
                    ref.read(superChatSortProvider.notifier).state = set.first;
                  }
                },
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _filterLabel(SuperChatFilter f, AppLocalizations l) => switch (f) {
        SuperChatFilter.all => l.filterAll,
        SuperChatFilter.unread => l.unread,
        SuperChatFilter.read => l.read,
      };
}

class _SuperChatTile extends StatelessWidget {
  final SuperChat superChat;
  final String resolvedName;
  final ValueChanged<String> onStatusChange;
  final VoidCallback onTapViewer;

  const _SuperChatTile({
    required this.superChat,
    required this.resolvedName,
    required this.onStatusChange,
    required this.onTapViewer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final amount = superChat.amountMicros / 1000000.0;
    final amountStr =
        '${superChat.currency} ${amount.toStringAsFixed(2)}';

    final isSticker = superChat.type == 'superStickerEvent';
    final isUnread = superChat.status == 'unread';

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: isUnread ? () => onStatusChange('read') : null,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        color: _tierColor(superChat.amountMicros, isUnread: isUnread, isSticker: isSticker),
        child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSticker
                    ? Colors.teal.withValues(alpha: 0.25)
                    : colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSticker)
                    Icon(Icons.auto_awesome, size: 13,
                        color: Colors.teal.shade700),
                  Text(
                    amountStr,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSticker
                          ? Colors.teal.shade800
                          : colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onTapViewer,
                    child: Text(
                      resolvedName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  if (superChat.messageText.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    isSticker
                        ? ChatMessageText(superChat.messageText, selectable: false, imageSize: 96.0)
                        : ChatMessageText(superChat.messageText, selectable: true),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    _formatDateTime(superChat.publishedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Read/unread toggle
            IconButton(
              icon: Icon(
                isUnread
                    ? Icons.mark_email_unread_rounded
                    : Icons.mark_email_read_rounded,
                color: isUnread ? Colors.orange : Colors.blue,
              ),
              tooltip: isUnread ? l.markRead : l.read,
              onPressed: isUnread ? () => onStatusChange('read') : null,
            ),
          ],
        ),
      ),
    ),
    );
  }

  Color _tierColor(int micros, {required bool isUnread, required bool isSticker}) {
    if (!isUnread) return Colors.grey.withValues(alpha: 0.04);
    if (isSticker) return Colors.teal.withValues(alpha: 0.10);
    final amount = micros / 1000000.0;
    if (amount >= 100) return Colors.red.withValues(alpha: 0.15);
    if (amount >= 50) return Colors.deepOrange.withValues(alpha: 0.15);
    if (amount >= 20) return Colors.orange.withValues(alpha: 0.14);
    if (amount >= 5) return Colors.amber.withValues(alpha: 0.12);
    return Colors.lightBlue.withValues(alpha: 0.10);
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}
