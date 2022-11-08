import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:qp_for_all/src/services/api.dart';

import 'src/app.dart' show App;
import 'src/controllers/settings.dart' show SettingsController;
import 'src/services/settings.dart' show SettingsService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  APIService().initialize();
  runApp(App(settingsController: settingsController));
}
