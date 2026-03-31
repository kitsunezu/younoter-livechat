import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/providers/providers.dart';
import '../../core/youtube/live_chat_manager.dart';
import '../../l10n/app_localizations.dart';
import '../chat/chat_message_text.dart';
import '../viewers/viewer_detail_panel.dart';

class MembershipPage extends ConsumerWidget {
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(liveChatManagerProvider);
    final statusAsync = ref.watch(chatStatusProvider);
    final status = statusAsync.valueOrNull ?? ChatConnectionStatus.disconnected;
    final liveChatId = manager.liveChatId;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = AppLocalizations.of(context)!;

    if (liveChatId == null || status != ChatConnectionStatus.connected) {
      return Center(
        child: Text(
          l.connectToSeeStats,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      children: [
        // Stats summary
        _MembershipStatsRow(liveChatId: liveChatId),
        const Divider(height: 1),
        // Membership events list
        Expanded(
          child: _MembershipList(liveChatId: liveChatId),
        ),
      ],
    );
  }
}

class _MembershipStatsRow extends ConsumerWidget {
  final String liveChatId;
  const _MembershipStatsRow({required this.liveChatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newMembers = ref.watch(newMemberCountProvider(liveChatId));
    final gifted = ref.watch(giftedMembershipCountProvider(liveChatId));
    final milestones = ref.watch(milestoneCountProvider(liveChatId));
    final l = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _MiniStatCard(
            icon: Icons.person_add,
            label: l.newMembers,
            value: newMembers.when(
              data: (v) => v.toString(),
              loading: () => l.counting,
              error: (_, __) => '-',
            ),
            color: Colors.green,
          ),
          _MiniStatCard(
            icon: Icons.card_giftcard,
            label: l.giftedMemberships,
            value: gifted.when(
              data: (v) => v.toString(),
              loading: () => l.counting,
              error: (_, __) => '-',
            ),
            color: Colors.purple,
          ),
          _MiniStatCard(
            icon: Icons.emoji_events,
            label: l.milestones,
            value: milestones.when(
              data: (v) => v.toString(),
              loading: () => l.counting,
              error: (_, __) => '-',
            ),
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MiniStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MembershipList extends ConsumerWidget {
  final String liveChatId;
  const _MembershipList({required this.liveChatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipsAsync = ref.watch(membershipsProvider(liveChatId));
    final viewersMap = ref.watch(chatViewersMapProvider(liveChatId)).valueOrNull ?? {};
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;

    return membershipsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (memberships) {
        if (memberships.isEmpty) {
          return Center(
            child: Text(
              l.noMembershipEvents,
              style: theme.textTheme.bodyLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: memberships.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final m = memberships[index];
            final viewer = viewersMap[m.channelId];
            final resolvedName = (viewer?.username?.isNotEmpty ?? false)
                ? viewer!.username!
                : m.displayName;
            return _MembershipTile(
              membership: m,
              resolvedName: resolvedName,
              onTapViewer: () => _openViewerSheet(context, m.channelId),
            );
          },
        );
      },
    );
  }
}

class _MembershipTile extends StatelessWidget {
  final Membership membership;
  final String resolvedName;
  final VoidCallback onTapViewer;

  const _MembershipTile({
    required this.membership,
    required this.resolvedName,
    required this.onTapViewer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = AppLocalizations.of(context)!;

    final (icon, color, label) = _typeInfo(membership.type, l);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      color: color.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Type icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
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
                    ],
                  ),
                  if (membership.messageText.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    ChatMessageText(
                      membership.messageText,
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (membership.milestoneMonths > 0 ||
                      membership.membershipLevel.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      [
                        if (membership.milestoneMonths > 0)
                          '${membership.milestoneMonths} ${l.months}',
                        if (membership.membershipLevel.isNotEmpty)
                          membership.membershipLevel,
                      ].join(' • '),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (membership.giftCount > 0) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${membership.giftCount} ${l.gifted}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.purple.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Timestamp
            Text(
              _formatDateTime(membership.publishedAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  (IconData, Color, String) _typeInfo(String type, AppLocalizations l) {
    return switch (type) {
      'newSponsorEvent' => (Icons.person_add, Colors.green, l.newMember),
      'membershipGiftingEvent' =>
        (Icons.card_giftcard, Colors.purple, l.giftedMembership),
      'memberMilestoneChatEvent' =>
        (Icons.emoji_events, Colors.orange, l.milestone),
      _ => (Icons.card_membership, Colors.grey, type),
    };
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
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
