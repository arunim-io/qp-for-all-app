import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;

import 'src/config/app.dart' show App;
import 'src/modules/settings/controller.dart' show SettingsController;
import 'src/modules/settings/service.dart' show SettingsService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(App(settingsController: settingsController));
}
