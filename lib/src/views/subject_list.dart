import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show subjectSearchProvider, subjectsProvider;
import '../widgets/search_bar.dart' show SearchBar;
import '../widgets/subject_card.dart' show SubjectCard;
import 'error.dart' show ErrorView;

/// A widget class that displays all the subjects.
class SubjectListView extends ConsumerWidget {
  ///
  const SubjectListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: const Text('QP for All')),
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(
            const Duration(seconds: 1),
            () => ref.refresh(subjectsProvider.future),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SearchBar(provider: subjectSearchProvider),
                const SizedBox(height: 25),
                ref.watch(subjectsProvider).when(
                      error: (error, stackTrace) => ErrorView(
                        error: error,
                        stackTrace: stackTrace,
                      ),
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      },
                      data: (subjects) => Expanded(
                        child: ListView.builder(
                          restorationId: 'SubjectListView',
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: subjects.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SubjectCard(subject: subjects[index]);
                          },
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      );
}
