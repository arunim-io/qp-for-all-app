// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/settings.dart' show SettingsController;

/// A Widget that shows the information of this app.
class AboutView extends HookWidget {
  ///
  const AboutView({super.key, required this.settingsController});

  /// The route of this view.
  static const routeName = '/settings';

  /// settings controller
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final theme = useState(settingsController.themeMode);
    final isDarkTheme = theme.value == ThemeMode.dark;

    void toggleDarkMode(bool value) {
      theme.value = value ? ThemeMode.dark : ThemeMode.light;
      settingsController.updateThemeMode(theme.value);
    }

    return Scaffold(
      body: Column(
        children: [
          const Center(
            heightFactor: 5,
            child: Text('QP For All', textScaleFactor: 2),
          ),
          SettingsList(
            shrinkWrap: true,
            lightTheme: SettingsThemeData(
              titleTextColor: Theme.of(context).primaryColorDark,
            ),
            darkTheme: SettingsThemeData(
              titleTextColor: Theme.of(context).primaryColorLight,
              settingsListBackground: Theme.of(context).backgroundColor,
            ),
            sections: [
              SettingsSection(
                title: const Text('Settings'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: toggleDarkMode,
                    initialValue: isDarkTheme,
                    title: Text(
                      'Enable ${isDarkTheme ? 'light' : 'dark'} theme',
                    ),
                    leading: Icon(
                      // ignore: lines_longer_than_80_chars
                      isDarkTheme ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: const Text('Some useful links'),
                tiles: [
                  SettingsTile(
                    title: const Text('GitHub Repository'),
                    onPressed: (context) =>
                        launchUrl(Uri.parse('https://www.github.com/arunim-io/qp-for-all-app/')),
                  ),
                  SettingsTile(
                    title: const Text('Official Website'),
                    onPressed: (context) =>
                        launchUrl(Uri.parse('https://www.github.com/arunim-io/qp-for-all-app/')),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
