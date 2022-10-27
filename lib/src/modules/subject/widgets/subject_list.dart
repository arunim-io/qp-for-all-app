import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show SubjectsQuery, subjectsProvider;
import 'subject_list_item.dart' show SubjectListItemWidget;

class SubjectListWidget extends ConsumerWidget {
  const SubjectListWidget({super.key, required this.curriculum});

  final String curriculum;

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(subjectsProvider(SubjectsQuery(curriculum: curriculum))).when(
            data: (subjects) => ListView.builder(
              restorationId: 'subjectsListView',
              itemCount: subjects.length,
              itemBuilder: (BuildContext context, int index) =>
                  SubjectListItemWidget(subject: subjects[index], curriculum: curriculum),
            ),
            error: (error, stackTrace) => Center(
              child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
            ),
            loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          );
}
