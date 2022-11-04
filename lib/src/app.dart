import 'package:flex_color_scheme/flex_color_scheme.dart'
    show FlexAppBarStyle, FlexScheme, FlexThemeData;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;

import 'controllers/settings.dart' show SettingsController;
import 'views/home.dart' show HomeView;
import 'views/settings.dart' show SettingsView;
import 'views/subject.dart' show SubjectView;

class App extends StatelessWidget {
  const App({super.key, required this.settingsController});

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
              textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
              transparentStatusBar: true,
              useMaterial3: true,
              useMaterial3ErrorColors: true,
            ),
            darkTheme: FlexThemeData.dark(
              appBarStyle: FlexAppBarStyle.primary,
              scheme: FlexScheme.jungle,
              textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)
                  .apply(bodyColor: Colors.white, displayColor: Colors.white),
              transparentStatusBar: true,
              useMaterial3: true,
              useMaterial3ErrorColors: true,
            ),
            themeMode: settingsController.themeMode,
            onGenerateRoute: (RouteSettings routeSettings) => MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SubjectView.routeName:
                    return const SubjectView();
                  default:
                    return HomeView();
                }
              },
            ),
          ),
        ),
      );
}
