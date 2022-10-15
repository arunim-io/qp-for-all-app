import 'package:flutter/material.dart';
import 'package:qp_for_all/src/modules/subject/models/session.dart';
import 'package:qp_for_all/src/utils.dart';

class SessionListWidget extends StatelessWidget {
  const SessionListWidget({super.key, required this.qualification});

  final String qualification;

  final sessions = Session.list;

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
  Widget build(BuildContext context) {
    return ListView.builder(
      restorationId: 'sessionListView',
      itemCount: sessions.length,
      itemBuilder: (BuildContext context, int index) {
        final session = sessions[index];

        return ExpansionTile(
          title: Text(session.title),
          children: [
            tile('Paper 1'),
            tile('Paper 2'),
          ],
        );
      },
    );
  }
}
