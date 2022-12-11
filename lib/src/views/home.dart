import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../controllers/settings.dart' show SettingsController;
import 'about.dart' show AboutView;
import 'subject_list.dart' show SubjectListView;

/// A widget class that displays the home view of the app.
class HomeView extends HookWidget {
  ///
  const HomeView({super.key, required this.settingsController});

  /// The route of this view.
  static const routeName = '/';

  /// [SettingsController] passed from the parent widget.
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    void onBottomBarTapped(int value) => index.value = value;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index.value,
        onTap: onBottomBarTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
      body: [
        const SubjectListView(),
        AboutView(settingsController: settingsController),
      ].elementAt(index.value),
    );
  }
}
