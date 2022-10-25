import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/api/models.dart' show Subject;
import '../../../utils.dart' show openUrl;

class SessionListWidget extends ConsumerWidget {
  const SessionListWidget({super.key, required this.qualification, required this.subject});

  final String qualification;
  final Subject subject;

  Widget tile(String title) => ListTile(
        title: Row(
          children: [
            Text(title),
            TextButton(
              child: const Text('Question Paper'),
              onPressed: () => openUrl('https://www.google.com/'),
            ),
            const Text('-'),
            TextButton(
              child: const Text('Mark Scheme'),
              onPressed: () => openUrl('https://www.google.com/'),
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
              // tile('Paper 1'),
              // tile('Paper 2'),
              ListView.builder(itemBuilder: (context, index) {
                final paper = subject.papers[index];

                return tile(paper.title);
              }),
            ],
          );
        },
      );
}
