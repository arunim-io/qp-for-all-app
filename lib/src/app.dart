import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;

import 'controllers/settings.dart' show SettingsController;
import 'views/home.dart' show HomeView;
import 'views/pdf_view.dart' show PDFView;
import 'views/subject.dart' show SubjectView;

/// The entry point for the app.
class App extends StatelessWidget {
  ///
  const App({super.key, required this.settingsController});

  /// [SettingsController] passed from the parent widget.
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
                  case SubjectView.routeName:
                    return const SubjectView();
                  case PDFView.routeName:
                    return const PDFView();
                  default:
                    return HomeView(
                      settingsController: settingsController,
                    );
                }
              },
            ),
          ),
        ),
      );
}
