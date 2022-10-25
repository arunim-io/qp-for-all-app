import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qp_for_all/src/utils.dart' show openUrl;

import '../models.dart' show Subject, Paper;

class SessionListWidget extends ConsumerWidget {
  const SessionListWidget({super.key, required this.qualification, required this.subject});

  final String qualification;
  final Subject subject;

  Widget tile(Paper paper) => ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(paper.title),
            Row(
              children: [
                TextButton(
                  child: const Text('Question Paper'),
                  onPressed: () => openUrl(paper.qpUrl),
                ),
                const Text('-'),
                TextButton(
                  child: const Text('Mark Scheme'),
                  onPressed: () => openUrl(paper.msUrl),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView.builder(
        restorationId: 'sessionListView',
        itemCount: subject.sessions.length,
        itemBuilder: (BuildContext context, int index) {
          final session = subject.sessions[index];

          return ExpansionTile(
            title: Text(session.name),
            children: [
              ListView.builder(
                restorationId: 'paperListView',
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: subject.papers.length,
                itemBuilder: (context, index) => tile(subject.papers[index]),
              ),
            ],
          );
        },
      );
}
