import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show subjectsProvider;
import 'subject_card.dart' show SubjectCard;

class SubjectList extends ConsumerWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(subjectsProvider).when(
        data: (subjects) => ListView.builder(
          restorationId: 'subjectsListView',
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) => SubjectCard(subject: subjects[index]),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      );
}
