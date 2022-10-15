import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ConsumerWidget, WidgetRef;

import '../../../utils.dart' show openUrl;
import '../provider.dart' show sessionsProvider;

class SessionListWidget extends ConsumerWidget {
  const SessionListWidget({super.key, required this.qualification});

  final String qualification;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionsProvider);

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
