import 'package:flutter/material.dart';
import 'package:qp_for_all/src/modules/subject/providers.dart';

import '../models.dart' show Subject;
import '../views/subject.dart' show SubjectView;

class SubjectListItemWidget extends StatelessWidget {
  const SubjectListItemWidget({Key? key, required this.subject, required this.curriculum})
      : super(key: key);

  final Subject subject;
  final String curriculum;

  @override
  Widget build(BuildContext context) => Container(
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
              builder: (context) =>
                  SubjectView(query: SubjectQuery(id: subject.id, curriculum: curriculum)),
            ),
          ),
        ),
      );
}
