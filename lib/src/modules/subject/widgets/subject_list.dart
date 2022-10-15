import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ConsumerWidget, WidgetRef;

import '../provider.dart' show subjectsProvider;
import '../views/subject.dart' show SubjectView;

class SubjectList extends ConsumerWidget {
  const SubjectList({super.key, required this.curriculum});

  final String curriculum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.read(subjectsProvider);

    return ListView.builder(
      restorationId: 'subjectsListView',
      itemCount: subjects.length,
      itemBuilder: (BuildContext context, int index) => Container(
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/flutter_logo.png'), fit: BoxFit.cover),
        ),
        child: ListTile(
          title: Text(subjects[index].name, textScaleFactor: 1.75),
          minVerticalPadding: 5,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectView(id: subjects[index].id),
            ),
          ),
        ),
      ),
    );
  }
}
