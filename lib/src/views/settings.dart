import 'package:flutter/material.dart';

import '../controllers/settings.dart' show SettingsController;

/// A Widget that shows the settings of this app.
class SettingsView extends StatelessWidget {
  ///
  const SettingsView({super.key, required this.controller});

  /// The route of this view.
  static const routeName = '/settings';

  /// settings controller
  final SettingsController controller;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: const BackButton(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text('Theme: ', textScaleFactor: 1.25),
              DropdownButton(
                value: controller.themeMode,
                onChanged: controller.updateThemeMode,
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
