import 'package:flex_color_scheme/flex_color_scheme.dart'
    show FlexAppBarStyle, FlexScheme, FlexThemeData;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;

import 'controllers/settings.dart' show SettingsController;
import 'views/home.dart' show HomeView;
import 'views/pdf_view.dart';
import 'views/settings.dart' show SettingsView;
import 'views/subject.dart' show SubjectView;

/// The entry point for the app.
class App extends StatelessWidget {
  ///
  const App({super.key, required this.settingsController});

  /// Reference to the settings controller that is also used as a parameter.
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) => MaterialApp(
            restorationScopeId: 'app',
            theme: FlexThemeData.light(
              appBarStyle: FlexAppBarStyle.primary,
              scheme: FlexScheme.jungle,
              textTheme: GoogleFonts.nunitoSansTextTheme(
                Theme.of(context).textTheme,
              ),
              useMaterial3: true,
              useMaterial3ErrorColors: true,
            ),
            darkTheme: FlexThemeData.dark(
              appBarStyle: FlexAppBarStyle.primary,
              scheme: FlexScheme.jungle,
              textTheme: GoogleFonts.nunitoSansTextTheme(
                Theme.of(context).textTheme,
              ).apply(bodyColor: Colors.white, displayColor: Colors.white),
              useMaterial3: true,
              useMaterial3ErrorColors: true,
            ),
            themeMode: settingsController.themeMode,
            onGenerateRoute: (RouteSettings routeSettings) => MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SubjectView.routeName:
                    return const SubjectView();
                  case PDFView.routeName:
                    return const PDFView();
                  default:
                    return const HomeView();
                }
              },
            ),
          ),
        ),
      );
}
