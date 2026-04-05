import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';

import '../../core/database/database.dart';
import '../../core/providers/providers.dart';
import '../../core/youtube/currency_utils.dart';
import '../../core/youtube/live_chat_manager.dart';
import '../viewers/viewer_detail_panel.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(liveChatManagerProvider);
    // Watch connection status so the page rebuilds on connect/disconnect.
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stream info header
          _StreamInfoHeader(
            videoId: manager.videoId,
            title: manager.currentStreamTitle,
            ownerChannelName: manager.currentOwnerChannelName,
          ),
          const SizedBox(height: 16),
          // Stats cards row
          _StatsCardsRow(liveChatId: liveChatId),
          const SizedBox(height: 24),
          // Top donors
          Text(l.topDonors, style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          _TopDonorsSection(liveChatId: liveChatId),
          const SizedBox(height: 24),
          // Super Chat distribution charts — side by side on desktop, stacked on mobile
          Text(l.superChatDistribution, style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          _ChartsSection(liveChatId: liveChatId),
        ],
      ),
    );
  }
}

/// Shows the current stream's thumbnail, channel name, title, and connected time.
class _StreamInfoHeader extends StatelessWidget {
  final String? videoId;
  final String? title;
  final String? ownerChannelName;

  const _StreamInfoHeader({
    this.videoId,
    this.title,
    this.ownerChannelName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final thumbUrl = videoId != null
        ? 'https://i.ytimg.com/vi/$videoId/mqdefault.jpg'
        : null;
    final streamUrl = videoId != null
        ? Uri.parse('https://www.youtube.com/watch?v=$videoId')
        : null;

    Widget card = Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: streamUrl != null
            ? () => launchUrl(streamUrl, mode: LaunchMode.externalApplication)
            : null,
        mouseCursor: streamUrl != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: thumbUrl != null
                  ? Image.network(
                      thumbUrl,
                      width: 120,
                      height: 68,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 120,
                        height: 68,
                        color: colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.live_tv, size: 32),
                      ),
                    )
                  : Container(
                      width: 120,
                      height: 68,
                      color: colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.live_tv, size: 32),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null && title!.isNotEmpty)
                    Text(
                      title!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (ownerChannelName != null &&
                      ownerChannelName!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.person,
                            size: 16, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            ownerChannelName!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (streamUrl != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.open_in_new,
                            size: 14, color: colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          'youtube.com/watch?v=$videoId',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );

    return card;
  }
}

/// Row of summary stat cards — uses aggregate SQL queries (no row limit).
class _StatsCardsRow extends ConsumerWidget {
  final String liveChatId;
  const _StatsCardsRow({required this.liveChatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msgCount = ref.watch(messageCountProvider(liveChatId));
    final viewerCount = ref.watch(uniqueViewerCountProvider(liveChatId));
    final scCount = ref.watch(superChatCountProvider(liveChatId));
    final superChatsAsync = ref.watch(superChatsProvider(liveChatId));
    final displayCurrency = ref.watch(displayCurrencyProvider);
    final newMemberCount = ref.watch(newMemberCountProvider(liveChatId));
    final giftedCount = ref.watch(giftedMembershipCountProvider(liveChatId));
    final milestoneCount = ref.watch(milestoneCountProvider(liveChatId));
    final manager = ref.watch(liveChatManagerProvider);
    // Watch peakViewersProvider to rebuild when peak updates.
    ref.watch(peakViewersProvider);
    final peakViewers = manager.peakViewers;
    final l = AppLocalizations.of(context)!;

    final normalizedTotal = superChatsAsync.when(
      data: (list) => list.fold<double>(
        0.0,
        (sum, sc) =>
            sum + convertAmount(sc.currency, sc.amountMicros, displayCurrency),
      ),
      loading: () => -1.0,
      error: (_, __) => -1.0,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 600
            ? 2
            : (constraints.maxWidth / 200).floor().clamp(2, 8);
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.55,
          children: [
        _StatCard(
          icon: Icons.chat_bubble_outline,
          label: l.totalMessages,
          value: msgCount.when(
            data: (v) => v.toString(),
            loading: () => l.counting,
            error: (_, __) => '-',
          ),
          color: Colors.blue,
        ),
        _StatCard(
          icon: Icons.monetization_on_outlined,
          label: l.totalSuperChats,
          value: scCount.when(
            data: (v) => v.toString(),
            loading: () => l.counting,
            error: (_, __) => '-',
          ),
          color: Colors.amber,
        ),
        _StatCard(
          icon: Icons.attach_money,
          label: '${l.totalAmount} ($displayCurrency)',
          value: normalizedTotal < 0
              ? l.counting
              : formatConvertedAmount(displayCurrency, normalizedTotal),
          color: Colors.green,
        ),
        _StatCard(
          icon: Icons.people_outline,
          label: l.activeViewers,
          value: viewerCount.when(
            data: (v) => v.toString(),
            loading: () => l.counting,
            error: (_, __) => '-',
          ),
          color: Colors.blueGrey,
        ),
        _StatCard(
          icon: Icons.person_add,
          label: l.newMembers,
          value: newMemberCount.when(
            data: (v) => v.toString(),
            loading: () => l.counting,
            error: (_, __) => '-',
          ),
          color: Colors.green,
        ),
        _StatCard(
          icon: Icons.card_giftcard,
          label: l.giftedMemberships,
          value: giftedCount.when(
            data: (v) => v.toString(),
            loading: () => l.counting,
            error: (_, __) => '-',
          ),
          color: Colors.purple,
        ),
        _StatCard(
          icon: Icons.emoji_events,
          label: l.milestones,
          value: milestoneCount.when(
            data: (v) => v.toString(),
            loading: () => l.counting,
            error: (_, __) => '-',
          ),
          color: Colors.teal,
        ),
        _StatCard(
          icon: Icons.visibility_outlined,
          label: l.peakViewers,
          value: peakViewers != null
              ? peakViewers.toString()
              : l.counting,
          color: Colors.deepOrange,
        ),
      ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 6),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Normalized donor result computed in Dart with currency conversion.
class _NormalizedDonor {
  final String channelId;
  final String displayName;
  final double totalUsd;
  final Map<String, double> originalAmounts;

  _NormalizedDonor({
    required this.channelId,
    required this.displayName,
    required this.totalUsd,
    required this.originalAmounts,
  });

  String get originalSummary {
    final entries = originalAmounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .map((entry) => formatRawCurrencyAmount(entry.key, entry.value))
        .join(' + ');
  }
}

/// Two pie charts: side by side on desktop (≥600), stacked on mobile (<600).
class _ChartsSection extends StatelessWidget {
  final String liveChatId;
  const _ChartsSection({required this.liveChatId});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.topDonors,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 6),
              SizedBox(
                height: 280,
                child: _SuperChatChart(liveChatId: liveChatId),
              ),
              const SizedBox(height: 16),
              Text(l.currencyDistribution,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 6),
              SizedBox(
                height: 280,
                child: _CurrencyPieChart(liveChatId: liveChatId),
              ),
            ],
          );
        }
        return SizedBox(
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.topDonors,
                        style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 6),
                    Expanded(
                        child: _SuperChatChart(liveChatId: liveChatId)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.currencyDistribution,
                        style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 6),
                    Expanded(
                        child: _CurrencyPieChart(liveChatId: liveChatId)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

List<_NormalizedDonor> _computeTopDonors(List<SuperChat> superChats,
    {int? limit}) {
  final map = <String, _NormalizedDonor>{};
  for (final sc in superChats) {
    final usd = normalizeToUsd(sc.currency, sc.amountMicros);
    final existing = map[sc.channelId];
    if (existing != null) {
      final mergedOriginalAmounts =
          Map<String, double>.from(existing.originalAmounts);
      mergedOriginalAmounts.update(
        sc.currency,
        (value) => value + (sc.amountMicros / 1000000.0),
        ifAbsent: () => sc.amountMicros / 1000000.0,
      );
      map[sc.channelId] = _NormalizedDonor(
        channelId: sc.channelId,
        displayName: sc.displayName,
        totalUsd: existing.totalUsd + usd,
        originalAmounts: mergedOriginalAmounts,
      );
    } else {
      map[sc.channelId] = _NormalizedDonor(
        channelId: sc.channelId,
        displayName: sc.displayName,
        totalUsd: usd,
        originalAmounts: {
          sc.currency: sc.amountMicros / 1000000.0,
        },
      );
    }
  }
  final sorted = map.values.toList()
    ..sort((a, b) => b.totalUsd.compareTo(a.totalUsd));
  return limit != null ? sorted.take(limit).toList() : sorted;
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

/// Top donors list.
class _TopDonorsSection extends ConsumerWidget {
  final String liveChatId;
  const _TopDonorsSection({required this.liveChatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final superChatsAsync = ref.watch(superChatsProvider(liveChatId));
    final viewersMap = ref.watch(chatViewersMapProvider(liveChatId)).valueOrNull ?? {};

    return superChatsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
      data: (superChats) {
        final donors = _computeTopDonors(superChats);
        if (donors.isEmpty) {
          return Text(AppLocalizations.of(context)!.noSuperChatDonors);
        }
        // Each dense ListTile is ~48px; show max 5 items then scroll.
        const itemHeight = 48.0;
        const maxVisible = 5;
        final constrainedHeight = donors.length > maxVisible
            ? itemHeight * maxVisible
            : itemHeight * donors.length;
        final scrollController = ScrollController();
        return SizedBox(
          height: constrainedHeight,
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: donors.length > maxVisible,
            child: ListView.builder(
              controller: scrollController,
              itemCount: donors.length,
              itemBuilder: (context, i) {
                final donor = donors[i];
                final viewer = viewersMap[donor.channelId];
                final resolvedName = (viewer?.username?.isNotEmpty ?? false)
                    ? viewer!.username!
                    : donor.displayName;
                return ListTile(
                  dense: true,
                  leading: CircleAvatar(
                    radius: 16,
                    child: Text('${i + 1}'),
                  ),
                  title: Text(resolvedName),
                  trailing: Text(
                    donor.originalSummary,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () => _openViewerSheet(context, donor.channelId),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// Pie chart of Super Chat amounts by viewer (USD-normalised).
class _SuperChatChart extends ConsumerStatefulWidget {
  final String liveChatId;
  const _SuperChatChart({required this.liveChatId});

  @override
  ConsumerState<_SuperChatChart> createState() => _SuperChatChartState();
}

class _SuperChatChartState extends ConsumerState<_SuperChatChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final superChatsAsync = ref.watch(superChatsProvider(widget.liveChatId));
    final viewersMap = ref.watch(chatViewersMapProvider(widget.liveChatId)).valueOrNull ?? {};

    return superChatsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (superChats) {
        final donors = _computeTopDonors(superChats, limit: 5);
        if (donors.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)!.noData));
        }

        final total = donors.fold<double>(0, (s, d) => s + d.totalUsd);

        const colors = [
          Color(0xFFFF0000), // YouTube Red
          Color(0xFF1E88E5), // Blue
          Color(0xFFFFC107), // Amber
          Color(0xFF43A047), // Green
          Color(0xFFE040FB), // Purple/Pink
          Color(0xFFFF7043), // Deep Orange
          Color(0xFF00BCD4), // Cyan
          Color(0xFF8D6E63), // Brown
          Color(0xFF7C4DFF), // Deep Purple
          Color(0xFF26A69A), // Teal
        ];

        return PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, PieTouchResponse? resp) {
                final idx = resp?.touchedSection?.touchedSectionIndex ?? -1;
                setState(() {
                  _touchedIndex = event.isInterestedForInteractions ? idx : -1;
                });
                if (event is FlTapUpEvent && idx >= 0 && idx < donors.length) {
                  _openViewerSheet(context, donors[idx].channelId);
                }
              },
            ),
            sections: donors.asMap().entries.map((entry) {
              final i = entry.key;
              final donor = entry.value;
              final viewer = viewersMap[donor.channelId];
              final resolvedName = (viewer?.username?.isNotEmpty ?? false)
                  ? viewer!.username!
                  : donor.displayName;
              final isTouched = i == _touchedIndex;
              final pct = total > 0
                  ? (donor.totalUsd / total * 100).toStringAsFixed(1)
                  : '0';
              return PieChartSectionData(
                value: donor.totalUsd,
                title: '$resolvedName\n${donor.originalSummary}\n$pct%',
                color: colors[i % colors.length],
                radius: isTouched ? 108.0 : 90.0,
                titleStyle: TextStyle(
                  fontSize: isTouched ? 12 : 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: isTouched
                      ? const [Shadow(color: Colors.black38, blurRadius: 4)]
                      : null,
                ),
              );
            }).toList(),
            sectionsSpace: 2,
            centerSpaceRadius: 30,
          ),
        );
      },
    );
  }
}

/// Pie chart of Super Chat amounts grouped by currency (USD-normalised for proportion).
class _CurrencyPieChart extends ConsumerStatefulWidget {
  final String liveChatId;
  const _CurrencyPieChart({required this.liveChatId});

  @override
  ConsumerState<_CurrencyPieChart> createState() => _CurrencyPieChartState();
}

class _CurrencyPieChartState extends ConsumerState<_CurrencyPieChart> {
  int _touchedIndex = -1;

  static const _colors = [
    Color(0xFF1E88E5), // Blue
    Color(0xFFFF0000), // YouTube Red
    Color(0xFFFFC107), // Amber
    Color(0xFF43A047), // Green
    Color(0xFFE040FB), // Purple
    Color(0xFFFF7043), // Deep Orange
    Color(0xFF00BCD4), // Cyan
    Color(0xFF8D6E63), // Brown
    Color(0xFF7C4DFF), // Deep Purple
    Color(0xFF26A69A), // Teal
  ];

  @override
  Widget build(BuildContext context) {
    final superChatsAsync = ref.watch(superChatsProvider(widget.liveChatId));

    return superChatsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (superChats) {
        if (superChats.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context)!.noData));
        }

        // Aggregate by currency: USD equivalent for proportions, raw amount for display
        final usdByCurrency = <String, double>{};
        final rawByCurrency = <String, double>{};
        for (final sc in superChats) {
          final usd = normalizeToUsd(sc.currency, sc.amountMicros);
          usdByCurrency.update(sc.currency, (v) => v + usd, ifAbsent: () => usd);
          rawByCurrency.update(
            sc.currency,
            (v) => v + sc.amountMicros / 1000000.0,
            ifAbsent: () => sc.amountMicros / 1000000.0,
          );
        }

        final sorted = usdByCurrency.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        final totalUsd = sorted.fold<double>(0, (s, e) => s + e.value);

        final sections = sorted.asMap().entries.map((entry) {
          final i = entry.key;
          final currency = entry.value.key;
          final usd = entry.value.value;
          final rawAmount = rawByCurrency[currency] ?? 0;
          final isTouched = i == _touchedIndex;
          final pct = totalUsd > 0 ? (usd / totalUsd * 100) : 0.0;
          final pctStr = pct.toStringAsFixed(1);
          final sym = currencySymbol(currency);
          return PieChartSectionData(
            value: usd,
            title: '$sym${rawAmount.toStringAsFixed(0)}\n$pctStr%',
            color: _colors[i % _colors.length],
            radius: isTouched ? 110.0 : 90.0,
            titleStyle: TextStyle(
              fontSize: isTouched ? 12 : 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: isTouched
                  ? const [Shadow(color: Colors.black38, blurRadius: 4)]
                  : null,
            ),
          );
        }).toList();

        return Row(
          children: [
            Expanded(
              flex: 3,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, PieTouchResponse? resp) {
                      final idx = resp?.touchedSection?.touchedSectionIndex ?? -1;
                      setState(() {
                        _touchedIndex = event.isInterestedForInteractions ? idx : -1;
                      });
                    },
                  ),
                  sections: sections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 28,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Legend
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sorted.asMap().entries.map((entry) {
                  final i = entry.key;
                  final currency = entry.value.key;
                  final usd = entry.value.value;
                  final rawAmount = rawByCurrency[currency] ?? 0;
                  final pct = totalUsd > 0 ? (usd / totalUsd * 100) : 0.0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _colors[i % _colors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            () {
                              final sym = currencySymbol(currency);
                              // ISO code → show "JPY ¥ 700.00"; symbol only → show "¥ 700.00"
                              final prefix = sym != currency ? '$currency $sym' : currency;
                              return '$prefix ${rawAmount.toStringAsFixed(2)} (${pct.toStringAsFixed(1)}%)';
                            }(),
                            style: const TextStyle(fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
