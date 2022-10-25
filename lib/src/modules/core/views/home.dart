import 'package:flutter/material.dart';

import '../../settings/view.dart' show SettingsView;
import '../../subject/widgets/subject_list.dart' show SubjectListWidget;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
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
                      return;
                    default:
                      return;
                  }
                },
              )
            ],
            bottom: const TabBar(tabs: [
              Tab(text: 'Cambridge'),
              Tab(text: 'Edexcel'),
            ]),
          ),
          body: const Padding(
            padding: EdgeInsets.all(10),
            child: TabBarView(
              children: [
                SubjectListWidget(curriculum: 'Cambridge'),
                SubjectListWidget(curriculum: 'Edexcel'),
              ],
            ),
          ),
        ),
      );
}
