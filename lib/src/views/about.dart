import 'package:flutter/material.dart';

import '../controllers/settings.dart' show SettingsController;

/// A Widget that shows the information of this app.
class AboutView extends StatelessWidget {
  ///
  const AboutView({super.key, required this.settingsController});

  /// The route of this view.
  static const routeName = '/settings';

  /// settings controller
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text('Theme: ', textScaleFactor: 1.25),
              DropdownButton(
                value: settingsController.themeMode,
                onChanged: settingsController.updateThemeMode,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System Theme'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light Theme'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark Theme'),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
