import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/providers/providers.dart';
import '../../core/services/settings_service.dart';
import '../../core/youtube/currency_utils.dart';
import '../../l10n/app_localizations.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _apiKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _apiKeyController.text = ref.read(apiKeyProvider);
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;
    final isDark = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final alwaysOnTop = ref.watch(alwaysOnTopProvider);
    final displayCurrency = ref.watch(displayCurrencyProvider);
    final urlHistoryAsync = ref.watch(urlHistoryProvider);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(l.settingsTab, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 24),

        // API Key (optional)
        Text('YouTube API Key (${l.apiKeyOptional})',
            style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          l.apiKeyOptionalHint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _apiKeyController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your YouTube Data API v3 key',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {
                final key = _apiKeyController.text.trim();
                ref.read(apiKeyProvider.notifier).state = key;
                SettingsService.apiKey = key;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.saveNote),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Text(l.saveNote),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l.apiKeyHelp,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const Divider(height: 40),

        // Appearance
        Text('Appearance', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        SwitchListTile(
          title: Text(isDark ? l.darkMode : l.lightMode),
          secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          value: isDark,
          onChanged: (v) {
            ref.read(themeModeProvider.notifier).state = v;
            SettingsService.isDark = v;
          },
        ),

        SwitchListTile(
          title: Text(l.alwaysOnTop),
          secondary: const Icon(Icons.push_pin),
          value: alwaysOnTop,
          onChanged: (v) async {
            ref.read(alwaysOnTopProvider.notifier).state = v;
            SettingsService.alwaysOnTop = v;
            if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
              await windowManager.setAlwaysOnTop(v);
            }
          },
        ),

        const Divider(height: 40),

        // Display Name Mode
        Text(l.displayNameMode, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        SegmentedButton<DisplayNameMode>(
          segments: [
            ButtonSegment(
              value: DisplayNameMode.usernameAndHandle,
              label: Text(l.usernameAndHandle),
            ),
            ButtonSegment(
              value: DisplayNameMode.usernameOnly,
              label: Text(l.usernameOnly),
            ),
            ButtonSegment(
              value: DisplayNameMode.handleOnly,
              label: Text(l.handleOnly),
            ),
          ],
          selected: {ref.watch(displayNameModeProvider)},
          onSelectionChanged: (v) {
            ref.read(displayNameModeProvider.notifier).state = v.first;
            SettingsService.displayNameMode = v.first;
          },
        ),

        const Divider(height: 40),

        // Chat Font Size
        Text(l.chatFontSize, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        SegmentedButton<ChatFontSize>(
          segments: [
            ButtonSegment(
              value: ChatFontSize.small,
              label: Text(l.fontSmall),
            ),
            ButtonSegment(
              value: ChatFontSize.medium,
              label: Text(l.fontMedium),
            ),
            ButtonSegment(
              value: ChatFontSize.large,
              label: Text(l.fontLarge),
            ),
          ],
          selected: {ref.watch(chatFontSizeProvider)},
          onSelectionChanged: (v) {
            ref.read(chatFontSizeProvider.notifier).state = v.first;
            SettingsService.chatFontSize = v.first;
          },
        ),

        const Divider(height: 40),

        Text('Display Currency', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownMenu<String>(
          initialSelection: displayCurrency,
          width: 220,
          onSelected: (value) {
            if (value == null) return;
            ref.read(displayCurrencyProvider.notifier).state = value;
            SettingsService.displayCurrency = value;
          },
          dropdownMenuEntries: supportedDisplayCurrencies
              .map(
                (currency) => DropdownMenuEntry(
                  value: currency,
                  label: currency,
                ),
              )
              .toList(),
        ),

        const Divider(height: 40),

        // Language
        Text(l.language, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownMenu<String>(
          initialSelection: locale,
          width: 220,
          onSelected: (v) {
            if (v == null) return;
            ref.read(localeProvider.notifier).state = v;
            SettingsService.locale = v;
          },
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'en', label: 'English'),
            DropdownMenuEntry(
              value: SettingsService.traditionalChineseLocale,
              label: '繁體中文',
            ),
            DropdownMenuEntry(value: 'ja', label: '日本語'),
            DropdownMenuEntry(value: 'ko', label: '한국어'),
            DropdownMenuEntry(value: 'es', label: 'Español'),
            DropdownMenuEntry(value: 'fr', label: 'Français'),
            DropdownMenuEntry(value: 'de', label: 'Deutsch'),
            DropdownMenuEntry(value: 'pt', label: 'Português'),
          ],
        ),

        const Divider(height: 40),

        // URL History
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l.urlHistory, style: theme.textTheme.titleMedium),
            urlHistoryAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (streams) {
                if (streams.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l.clearHistory,
                  onPressed: () async {
                    final db = ref.read(databaseProvider);
                    await db.liveStreamDao.clearHistory();
                    ref.invalidate(urlHistoryProvider);
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        urlHistoryAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Error: $e'),
          data: (streams) {
            if (streams.isEmpty) {
              return Text(l.noMessages);
            }
            return Column(
              children: streams.map((s) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.history, size: 18),
                    title: Text(
                      s.url,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      _formatDate(s.connectedAt),
                      style: theme.textTheme.bodySmall,
                    ),
                    trailing: Text(s.videoId),
                  )).toList(),
            );
          },
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/'
        '${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}
