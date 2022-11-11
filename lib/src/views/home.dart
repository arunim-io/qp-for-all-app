import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show subjectSearchProvider, subjectsProvider;
import '../widgets/search_bar.dart' show SearchBar;
import '../widgets/subject_card.dart' show SubjectCard;
import 'error.dart' show ErrorView;
import 'settings.dart' show SettingsView;

/// This widget displays the home view of the app.
class HomeView extends StatelessWidget {
  ///
  const HomeView({super.key});

  /// The route of this view.
  static const routeName = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('QP for All'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('Settings')),
                const PopupMenuItem<int>(value: 1, child: Text('About')),
              ],
              onSelected: (value) => value == 0
                  ? Navigator.restorablePushNamed(
                      context,
                      SettingsView.routeName,
                    )
                  : null,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SearchBar(provider: subjectSearchProvider),
              const SizedBox(height: 25),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(subjectsProvider).when(
                          data: (subjects) => ListView.builder(
                            restorationId: 'SubjectListView',
                            itemCount: subjects.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SubjectCard(subject: subjects[index]);
                            },
                          ),
                          error: (error, stackTrace) => ErrorView(
                            error: error,
                            stackTrace: stackTrace,
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
