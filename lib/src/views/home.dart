import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show subjectsProvider;
import '../widgets/subject_card.dart' show SubjectCard;
import 'settings.dart' show SettingsView;

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  static const routeName = '/';

  final curriculums = ['Edexcel', 'Cambridge'];

  @override
  Widget build(BuildContext context, WidgetRef ref) => DefaultTabController(
        length: curriculums.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('QP for All'),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(value: 0, child: Text('Settings')),
                  const PopupMenuItem<int>(value: 1, child: Text('About')),
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ref.watch(subjectsProvider).when(
                  data: (subjects) => ListView.builder(
                    restorationId: 'subjectsListView',
                    itemCount: subjects.length,
                    itemBuilder: (BuildContext context, int index) => SubjectCard(
                      subject: subjects[index],
                    ),
                  ),
                  error: (error, stackTrace) {
                    log(error.toString());

                    return const Center(
                      child: Text(
                        'An error occurred. Please try again later',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                ),
          ),
        ),
      );
}
