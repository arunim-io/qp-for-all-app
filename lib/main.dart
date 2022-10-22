import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;

import 'src/config/app.dart' show App;
import 'src/config/firebase/options.dart' show DefaultFirebaseOptions;
import 'src/modules/settings/controller.dart' show SettingsController;
import 'src/modules/settings/service.dart' show SettingsService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(App(settingsController: settingsController));
}
