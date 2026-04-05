import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';

import '../../core/providers/providers.dart';
import '../../core/youtube/currency_utils.dart';
import '../chat/chat_message_text.dart';

class ViewerDetailPanel extends ConsumerStatefulWidget {
  final String channelId;
  final ScrollController? scrollController;
  const ViewerDetailPanel({super.key, required this.channelId, this.scrollController});

  @override
  ConsumerState<ViewerDetailPanel> createState() => _ViewerDetailPanelState();
}

class _ViewerDetailPanelState extends ConsumerState<ViewerDetailPanel> {
  final _noteController = TextEditingController();
  bool _editing = false;
  Timer? _debounce;
  late final ScrollController _scrollCtrl;
  bool _ownScrollCtrl = false;
  bool _showTopButton = false;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      _scrollCtrl = widget.scrollController!;
    } else {
      _scrollCtrl = ScrollController();
      _ownScrollCtrl = true;
    }
    _scrollCtrl.addListener(() {
      final show = _scrollCtrl.hasClients && _scrollCtrl.offset > 120;
      if (show != _showTopButton) setState(() => _showTopButton = show);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _saveNoteSync();
    _noteController.dispose();
    if (_ownScrollCtrl) _scrollCtrl.dispose();
    super.dispose();
  }

  void _onNoteChanged(String _) {
    _editing = true;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      _saveNoteSync();
    });
  }

  void _saveNoteSync() {
    if (!_editing) return;
    final db = ref.read(databaseProvider);
    db.viewerDao.updateNote(widget.channelId, _noteController.text);
    _editing = false;
  }

  @override
  Widget build(BuildContext context) {
    final viewerAsync = ref.watch(viewerProvider(widget.channelId));
    final ownerChannelsAsync = ref.watch(ownerChannelsProvider);
    final selectedOwnerChannelId = ref.watch(selectedOwnerChannelIdProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return viewerAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (viewer) {
        if (viewer == null) {
          return Center(child: Text(AppLocalizations.of(context)!.viewerNotFound));
        }

        if (!_editing) {
          _noteController.text = viewer.note;
        }

        final l = AppLocalizations.of(context)!;

        final nameHistory =
            (jsonDecode(viewer.nameHistory) as List).cast<String>();

        return Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              // Header
              Row(
                children: [
                  if (viewer.avatarUrl != null && viewer.avatarUrl!.isNotEmpty)
                    CircleAvatar(
                      backgroundImage: NetworkImage(viewer.avatarUrl!),
                      radius: 24,
                    )
                  else
                    CircleAvatar(
                      radius: 24,
                      child: Text((viewer.username ?? viewer.displayName)[0].toUpperCase()),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewer.username ?? viewer.displayName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (viewer.handle != null)
                          Text(
                            '@${viewer.handle}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.open_in_new),
                    tooltip: 'YouTube Channel',
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                            'https://www.youtube.com/channel/${viewer.channelId}'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  // Highlight toggle
                  Consumer(builder: (context, ref, _) {
                    final highlighted =
                        ref.watch(highlightedViewersProvider);
                    final isHighlighted =
                        highlighted.contains(viewer.channelId);
                    return IconButton(
                      icon: Icon(
                        isHighlighted
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: Colors.amber.shade600,
                      ),
                      tooltip: isHighlighted
                          ? l.removeHighlight
                          : l.highlightViewer,
                      onPressed: () {
                        ref
                            .read(highlightedViewersProvider.notifier)
                            .update((s) {
                          final updated = Set<String>.from(s);
                          if (updated.contains(viewer.channelId)) {
                            updated.remove(viewer.channelId);
                          } else {
                            updated.add(viewer.channelId);
                          }
                          return updated;
                        });
                      },
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: colorScheme.error),
                    tooltip: l.deleteViewer,
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(l.deleteViewer),
                          content: Text(l.deleteViewerConfirm),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text(l.cancel),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text(l.confirm),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        final db = ref.read(databaseProvider);
                        await db.viewerDao.deleteViewer(viewer.channelId);
                        ref.read(selectedViewerIdProvider.notifier).state =
                            null;
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      final route = ModalRoute.of(context);
                      if (route is PopupRoute) {
                        Navigator.of(context).pop();
                      } else {
                        ref.read(selectedViewerIdProvider.notifier).state =
                            null;
                      }
                    },
                  ),
                ],
              ),
              const Divider(height: 24),

              // Note section
              Text(l.viewerNote, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: l.noteHint,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: _onNoteChanged,
              ),
              const SizedBox(height: 16),

              // Info section
              _InfoRow(label: l.channelId, value: viewer.channelId),
              _InfoRow(
                label: l.firstSeen,
                value: _formatDate(viewer.firstSeen),
              ),
              _InfoRow(
                label: l.lastSeen,
                value: _formatDate(viewer.lastSeen),
              ),

              const SizedBox(height: 16),
              ownerChannelsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (channels) => DropdownMenu<String>(
                  initialSelection: selectedOwnerChannelId,
                  width: 320,
                  label: Text(l.broadcasterChannel),
                  onSelected: (value) {
                    ref.read(selectedOwnerChannelIdProvider.notifier).state =
                        value ?? '';
                  },
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: '', label: l.allChannels),
                    ...channels.map(
                      (channel) => DropdownMenuEntry(
                        value: channel.ownerChannelId,
                        label: channel.ownerChannelName.isNotEmpty
                            ? channel.ownerChannelName
                            : channel.ownerChannelId,
                      ),
                    ),
                  ],
                ),
              ),

              // Name history
              if (nameHistory.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(l.nameHistory, style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                ...nameHistory.map(
                  (name) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],

              // Super Chat history
              const SizedBox(height: 16),
              _ViewerSuperChatSection(channelId: widget.channelId),

              // Chat history
              const SizedBox(height: 16),
              _ViewerChatSection(channelId: widget.channelId),
            ],
          ),
            ),
            if (_showTopButton)
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton.small(
                  onPressed: () => _scrollCtrl.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                  tooltip: l.backToTop,
                  child: const Icon(Icons.arrow_upward),
                ),
              ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/'
        '${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows this viewer's Super Chat history.
class _ViewerSuperChatSection extends ConsumerWidget {
  final String channelId;
  const _ViewerSuperChatSection({required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final scAsync = ref.watch(viewerSuperChatsProvider(channelId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.superChatHistory, style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        scAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (e, _) => Text('Error: $e'),
          data: (superChats) {
            if (superChats.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  l.noSuperChatHistory,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: superChats.map((sc) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Text(
                        formatCurrencyAmount(sc.currency, sc.amountMicros),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChatMessageText(
                          sc.messageText,
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(sc.publishedAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

/// Shows this viewer's chat message history.
class _ViewerChatSection extends ConsumerWidget {
  final String channelId;
  const _ViewerChatSection({required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = AppLocalizations.of(context)!;
    final msgsAsync = ref.watch(viewerMessagesProvider(channelId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.chatHistory, style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        msgsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (e, _) => Text('Error: $e'),
          data: (messages) {
            if (messages.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  l.noChatHistory,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: messages.map((msg) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ChatMessageText(
                          msg.messageText,
                          style: theme.textTheme.bodySmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(msg.publishedAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
