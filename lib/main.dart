import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart' show App;
import 'src/controllers/settings.dart' show SettingsController;
import 'src/services/api.dart' show APIService;
import 'src/services/settings.dart' show SettingsService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  await APIService().initialize();
  await Hive.initFlutter();
  runApp(App(settingsController: settingsController));
}
