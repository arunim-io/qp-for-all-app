import 'package:flutter/material.dart' show ChangeNotifier, ThemeMode;

import 'service.dart' show SettingsService;

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
class SettingsController with ChangeNotifier {
  SettingsController(this._service);

  final SettingsService _service;

  late ThemeMode _mode;

  ThemeMode get themeMode => _mode;

  /// Load the user's settings from the SettingsService.
  Future<void> loadSettings() async {
    _mode = await _service.themeMode();
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _mode) return;

    _mode = newThemeMode;
    notifyListeners();
    await _service.updateThemeMode(newThemeMode);
  }
}
