import 'package:flutter/material.dart';

import '../models.dart' show Subject;
import '../services/api.dart' show SubjectQuery;
import '../utils.dart' show navigate;
import '../views/subject.dart' show SubjectView;

/// A card that takes in a [Subject].
///
/// It currently shows the name & links to it under the specified curriculum.
class SubjectCard extends StatelessWidget {
  ///
  const SubjectCard({super.key, required this.subject});

  /// Subject details
  final Subject subject;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(subject.name, textScaleFactor: 1.75),
              minVerticalPadding: 5,
            ),
            Column(
              children: subject.curriculums
                  .map(
                    (curriculum) => ListTile(
                      title: Text(curriculum),
                      onTap: () => navigate(
                        context,
                        (_) => SubjectView(
                          query: SubjectQuery(
                            id: subject.id,
                            curriculum: curriculum,
                          ),
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
