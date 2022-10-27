import 'package:flutter/material.dart';

import '../../../utils.dart' show openUrl;
import '../models.dart' show Paper, Session, Subject;

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.session, required this.subject});

  final Subject subject;
  final Session session;

  Widget paperView(Paper paper) => ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${paper.qualification} - ${paper.title}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: const Text('Question Paper'),
                  onPressed: () => openUrl(paper.qpUrl),
                ),
                TextButton(
                  child: const Text('Mark Scheme'),
                  onPressed: () => openUrl(paper.msUrl),
                ),
              ],
            ),
          ],
        ),
      );

  Widget view(Paper paper) => Column(
        children: subject.qualifications
            .where((element) => element == paper.qualification)
            .map((e) => paperView(paper))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(title: Text(session.name)),
          ListView.builder(
            restorationId: 'paperListView',
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: subject.papers.length,
            itemBuilder: (context, index) => view(subject.papers[index]),
          )
        ],
      ),
    );
  }
}
