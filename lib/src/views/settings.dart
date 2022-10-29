import 'package:flutter/material.dart';

import '../controllers/settings.dart' show SettingsController;

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

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
                  DropdownMenuItem(value: ThemeMode.system, child: Text('System Theme')),
                  DropdownMenuItem(value: ThemeMode.light, child: Text('Light Theme')),
                  DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark Theme'))
                ],
              ),
            ],
          ),
        ),
      );
}
