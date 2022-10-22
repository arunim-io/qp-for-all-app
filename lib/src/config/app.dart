import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;

import '../modules/core/views/home.dart' show HomeView;
import '../modules/settings/controller.dart' show SettingsController;
import '../modules/settings/view.dart' show SettingsView;
import '../modules/subject/views/subject.dart' show SubjectView;

class App extends StatelessWidget {
  const App({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) => MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'GB')],
            onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(useMaterial3: true),
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
                    return const HomeView();
                }
              },
            ),
          ),
        ),
      );
}
