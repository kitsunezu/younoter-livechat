import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/providers/providers.dart';
import '../../l10n/app_localizations.dart';
import '../viewers/viewer_detail_panel.dart';

class ViewerSearchPage extends ConsumerStatefulWidget {
  const ViewerSearchPage({super.key});

  @override
  ConsumerState<ViewerSearchPage> createState() => _ViewerSearchPageState();
}

class _ViewerSearchPageState extends ConsumerState<ViewerSearchPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final viewersAsync = ref.watch(viewerSearchResultsProvider);
    final ownerChannelsAsync = ref.watch(ownerChannelsProvider);
    final selectedOwnerChannelId = ref.watch(selectedOwnerChannelIdProvider);
    final selectedViewerId = ref.watch(selectedViewerIdProvider);
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    // Mobile bottom sheet for viewer detail
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
              builder: (ctx, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: ViewerDetailPanel(channelId: next),
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
        Expanded(
          flex: 3,
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    ownerChannelsAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (channels) => Row(
                        children: [
                          DropdownMenu<String>(
                            initialSelection: selectedOwnerChannelId,
                            width: 320,
                            label: Text(l.broadcasterChannel),
                            onSelected: (value) {
                              ref.read(selectedOwnerChannelIdProvider.notifier)
                                  .state = value ?? '';
                            },
                            dropdownMenuEntries: [
                              DropdownMenuEntry(
                                value: '',
                                label: l.allChannels,
                              ),
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
                          const SizedBox(width: 8),
                          if (selectedOwnerChannelId.isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.delete_outline,
                                  color: colorScheme.error),
                              tooltip: l.deleteChannelData,
                              onPressed: () async {
                                final channelName = channels
                                    .where((c) =>
                                        c.ownerChannelId ==
                                        selectedOwnerChannelId)
                                    .map((c) =>
                                        c.ownerChannelName.isNotEmpty
                                            ? c.ownerChannelName
                                            : c.ownerChannelId)
                                    .firstOrNull ?? selectedOwnerChannelId;
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(
                                        '${l.deleteChannelData} - $channelName'),
                                    content:
                                        Text(l.deleteChannelDataConfirm),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: Text(l.cancel),
                                      ),
                                      FilledButton(
                                        style: FilledButton.styleFrom(
                                          backgroundColor:
                                              colorScheme.error,
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: Text(l.confirm),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmed == true) {
                                  final db = ref.read(databaseProvider);
                                  await db.liveStreamDao
                                      .deleteByOwnerChannel(
                                          selectedOwnerChannelId);
                                  ref
                                      .read(selectedOwnerChannelIdProvider
                                          .notifier)
                                      .state = '';
                                  ref
                                      .read(
                                          selectedViewerIdProvider.notifier)
                                      .state = null;
                                }
                              },
                            ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete_sweep,
                                color: colorScheme.error),
                            tooltip: l.deleteAllData,
                            onPressed: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(l.deleteAllData),
                                  content: Text(l.deleteAllDataConfirm),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false),
                                      child: Text(l.cancel),
                                    ),
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor:
                                            colorScheme.error,
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(ctx, true),
                                      child: Text(l.confirm),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmed == true) {
                                final db = ref.read(databaseProvider);
                                await db.liveStreamDao.deleteAllData();
                                ref
                                    .read(selectedOwnerChannelIdProvider
                                        .notifier)
                                    .state = '';
                                ref
                                    .read(
                                        selectedViewerIdProvider.notifier)
                                    .state = null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: l.searchViewerHint,
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        isDense: true,
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  ref.read(viewerSearchQueryProvider.notifier)
                                      .state = '';
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        ref.read(viewerSearchQueryProvider.notifier).state = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              // Viewer list
              Expanded(
                child: viewersAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (viewers) {
                    if (viewers.isEmpty) {
                      return Center(
                        child: Text(
                          l.noViewersFound,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: viewers.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final viewer = viewers[index];
                        final isSelected =
                            selectedViewerId == viewer.channelId;
                        return _ViewerListTile(
                          viewer: viewer,
                          isSelected: isSelected,
                          onTap: () {
                            ref
                                .read(selectedViewerIdProvider.notifier)
                                .state = viewer.channelId;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Desktop side panel
        if (selectedViewerId != null && isWide) ...[
          const VerticalDivider(width: 1),
          SizedBox(
            width: 360,
            child: ViewerDetailPanel(channelId: selectedViewerId),
          ),
        ],
      ],
    );
  }
}

class _ViewerListTile extends StatelessWidget {
  final Viewer viewer;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewerListTile({
    required this.viewer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: isSelected ? colorScheme.primaryContainer : null,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
        leading: viewer.avatarUrl != null && viewer.avatarUrl!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(viewer.avatarUrl!),
                radius: 18,
              )
            : CircleAvatar(
                radius: 18,
                child: Text((viewer.username ?? viewer.displayName).isNotEmpty
                    ? (viewer.username ?? viewer.displayName)[0].toUpperCase()
                    : '?'),
              ),
        title: Text(
          viewer.username ?? viewer.displayName,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: viewer.handle != null && viewer.handle!.isNotEmpty
            ? Text(
                '@${viewer.handle}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Text(
          _formatDate(viewer.lastSeen),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}
