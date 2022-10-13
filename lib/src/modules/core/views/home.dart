import 'package:flutter/material.dart';

import '../../settings/view.dart' show SettingsView;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QP for All'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Settings')),
              const PopupMenuItem<int>(value: 1, child: Text('About'))
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.restorablePushNamed(context, SettingsView.routeName);
                  break;
                default:
                  return;
              }
            },
          )
        ],
      ),
      body: const Center(child: Text('Hello World!')),
    );
  }
}
