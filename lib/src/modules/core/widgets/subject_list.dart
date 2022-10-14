import 'package:flutter/material.dart';

import '../models/subject.dart' show Subject;

class SubjectList extends StatelessWidget {
  const SubjectList({super.key, required this.curriculum});

  final String curriculum;

  final subjects = const [
    Subject(1, 'Physics'),
    Subject(2, 'Chemistry'),
    Subject(3, 'Biology'),
    Subject(4, 'Maths'),
    Subject(5, 'English'),
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        restorationId: 'subjectsListView',
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) => GridTile(
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/flutter_logo.png'), fit: BoxFit.cover),
            ),
            child: Center(child: Text(subjects[index].name, textScaleFactor: 2)),
          ),
        ),
      );
}
