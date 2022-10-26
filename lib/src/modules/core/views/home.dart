import 'package:flutter/material.dart';

import '../../settings/view.dart' show SettingsView;
import '../../subject/widgets/subject_list.dart' show SubjectListWidget;

class HomeView extends StatelessWidget {
  HomeView({super.key});

  static const routeName = '/';

  final curriculums = ['Edexcel', 'Cambridge'];

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: curriculums.length,
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
            bottom: TabBar(
              tabs: curriculums.map<Tab>((item) => Tab(text: item)).toList(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: TabBarView(
              children: curriculums.map((item) => SubjectListWidget(curriculum: item)).toList(),
            ),
          ),
        ),
      );
}
