import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qp_for_all/src/config/api/models.dart' show Subject;
import 'package:qp_for_all/src/modules/subject/views/subject.dart' show SubjectView;

import '../providers.dart' show subjectsProvider;

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
                  builder: (context) => SubjectView(id: subject.id),
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(subjectsProvider(curriculum)).when(
        data: (data) {
          return view(data);
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      );
}
