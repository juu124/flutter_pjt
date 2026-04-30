import 'package:flutter/material.dart';
import '../services/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;  // 현재 테마모드 get

  Future<void> loadThemeMode() async {
    final isDarkMode = await PreferenceService.getDarkModeSetting();
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    await PreferenceService.setDarkModeSetting(isDark);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}