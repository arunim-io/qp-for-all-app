import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart' show Subject;
import '../provider.dart' show subjectsProvider;
import '../views/subject.dart' show SubjectView;

class SubjectListWidget extends ConsumerWidget {
  const SubjectListWidget({super.key, required this.curriculum});

  final String curriculum;

  Widget view(List<Subject> subjects) => ListView.builder(
        restorationId: 'subjectsListView',
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          final subject = subjects[index];

          return Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/flutter_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              title: Text(subject.name, textScaleFactor: 1.75),
              minVerticalPadding: 5,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectView(id: subject.docId),
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(subjectsProvider).when(
        data: (data) => view(data),
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      );
}
