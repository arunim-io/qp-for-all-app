import 'package:flutter/material.dart';

import '../models/subject.dart' show Subject;
import '../views/subject.dart' show SubjectView;

class SubjectList extends StatelessWidget {
  const SubjectList({super.key, required this.curriculum});

  final String curriculum;

  @override
  Widget build(BuildContext context) {
    const subjects = Subject.list;

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
          onTap: () => Navigator.restorablePushNamed(context, SubjectView.routeName),
        ),
      ),
    );
  }
}