import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils.dart' show openUrl;
import '../providers.dart' show sessionsProvider;

class SessionListWidget extends ConsumerWidget {
  const SessionListWidget({super.key, required this.qualification, required this.subjectId});

  final String qualification;
  final dynamic subjectId;

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
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(sessionsProvider(subjectId)).when(
        data: (sessions) => ListView.builder(
          restorationId: 'sessionListView',
          itemCount: sessions.length,
          itemBuilder: (BuildContext context, int index) {
            final session = sessions[index];

            return ExpansionTile(
              title: Text(session.name),
              children: [
                tile('Paper 1'),
                tile('Paper 2'),
              ],
            );
          },
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      );
}
