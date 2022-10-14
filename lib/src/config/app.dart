import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart';

import '../modules/core/views/home.dart' show HomeView;
import '../modules/settings/controller.dart' show SettingsController;
import '../modules/settings/view.dart' show SettingsView;

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({super.key, required this.settingsController});

  final SettingsController settingsController;

  // Glue the SettingsController to the MaterialApp.
  //
  // The AnimatedBuilder Widget listens to the SettingsController for changes.
  // Whenever the user updates their settings, the MaterialApp is rebuilt.
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) => MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',
          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', 'GB')],
          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) => MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case SettingsView.routeName:
                  return SettingsView(controller: settingsController);
                default:
                  return const HomeView();
              }
            },
          ),
        ),
      );
}
