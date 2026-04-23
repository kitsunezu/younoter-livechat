import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/providers.dart';

class SettingsService {
  static const traditionalChineseLocale = 'zh-Hant';
  static const _keyThemeDark = 'theme_dark';
  static const _keyLocale = 'locale';
  static const _keyAlwaysOnTop = 'always_on_top';
  static const _keyDisplayNameMode = 'display_name_mode';
  static const _keyDisplayCurrency = 'display_currency';
  static const _keyApiKey = 'api_key';
  static const _keyChatFontSize = 'chat_font_size';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDark => _prefs.getBool(_keyThemeDark) ?? true;
  static set isDark(bool v) => _prefs.setBool(_keyThemeDark, v);

  static String normalizeLocale(String locale) {
    if (locale == 'zh') {
      return traditionalChineseLocale;
    }
    return locale;
  }

  static Locale resolveLocale(String locale) {
    switch (normalizeLocale(locale)) {
      case traditionalChineseLocale:
        return const Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant',
        );
      default:
        return Locale(normalizeLocale(locale));
    }
  }

  static String get locale => normalizeLocale(_prefs.getString(_keyLocale) ?? 'en');
  static set locale(String v) => _prefs.setString(_keyLocale, normalizeLocale(v));

  static bool get alwaysOnTop => _prefs.getBool(_keyAlwaysOnTop) ?? false;
  static set alwaysOnTop(bool v) => _prefs.setBool(_keyAlwaysOnTop, v);

  static DisplayNameMode get displayNameMode {
    final index = _prefs.getInt(_keyDisplayNameMode) ?? 0;
    return DisplayNameMode
        .values[index.clamp(0, DisplayNameMode.values.length - 1)];
  }

  static set displayNameMode(DisplayNameMode v) =>
      _prefs.setInt(_keyDisplayNameMode, v.index);

  static String get displayCurrency =>
      _prefs.getString(_keyDisplayCurrency) ?? 'USD';
  static set displayCurrency(String v) =>
      _prefs.setString(_keyDisplayCurrency, v);

  static String get apiKey => _prefs.getString(_keyApiKey) ?? '';
  static set apiKey(String v) => _prefs.setString(_keyApiKey, v);

  static ChatFontSize get chatFontSize {
    final index = _prefs.getInt(_keyChatFontSize) ?? 1;
    return ChatFontSize
        .values[index.clamp(0, ChatFontSize.values.length - 1)];
  }

  static set chatFontSize(ChatFontSize v) =>
      _prefs.setInt(_keyChatFontSize, v.index);
}
