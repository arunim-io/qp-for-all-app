import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;

import 'src/config/app.dart' show App;
import 'src/config/firebase/options.dart' show DefaultFirebaseOptions;
import 'src/modules/settings/controller.dart' show SettingsController;
import 'src/modules/settings/service.dart' show SettingsService;

void main() async {
  // Make sure that all bindings & plugins are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Load Firebase into the application.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(App(settingsController: settingsController));
}
