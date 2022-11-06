import 'package:flutter/material.dart';
import 'package:qp_for_all/src/utils.dart';

import '../models.dart' show Subject;
import '../providers.dart' show SubjectQuery;
import '../views/subject.dart' show SubjectView;

class SubjectCard extends StatelessWidget {
  const SubjectCard({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text(subject.name, textScaleFactor: 1.75), minVerticalPadding: 5),
            Column(
              children: subject.curriculums
                  .map(
                    (curriculum) => ListTile(
                      title: Text(curriculum),
                      onTap: () => navigate(
                        context,
                        (_) => SubjectView(
                          query: SubjectQuery(id: subject.id, curriculum: curriculum),
                          subjectName: subject.name,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
}
