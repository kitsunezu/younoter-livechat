import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app_shell.dart';
import 'app/theme.dart';
import 'core/providers/providers.dart';
import 'core/services/settings_service.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SettingsService.init();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    await windowManager.setTitle('YouNoter');
    await windowManager.setMinimumSize(const Size(320, 500));
  }

  runApp(const ProviderScope(child: YouNoterApp()));
}

class YouNoterApp extends ConsumerWidget {
  const YouNoterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'YouNoter',
      debugShowCheckedModeBanner: false,
      theme: younoterLightTheme,
      darkTheme: younoterDarkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      locale: SettingsService.resolveLocale(locale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: appRouter,
    );
  }
}
