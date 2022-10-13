import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/config/app.dart';
import 'src/config/firebase/options.dart';
import 'src/modules/settings/controller.dart';
import 'src/modules/settings/service.dart';

void main() async {
  // Make sure that all bindings & plugins are initialized.
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
