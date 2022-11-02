import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show SubjectQuery, subjectProvider;
import '../widgets/session_card.dart' show SessionCard;
import 'error.dart' show ErrorView;

class SubjectView extends ConsumerWidget {
  const SubjectView({super.key, this.query});

  final SubjectQuery? query;

  static const routeName = '/subject';

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(subjectProvider(query!)).when(
        error: (error, stackTrace) => ErrorView(error: error, stackTrace: stackTrace),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        data: (subject) => Scaffold(
          appBar: AppBar(
            title: Text(subject.name),
            leading: const BackButton(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child:
                subject.papers.where((element) => element.curriculum == query!.curriculum).isEmpty
                    ? const Center(child: Text('Nothing to show'))
                    : ListView.builder(
                        restorationId: 'SessionListView',
                        itemCount: subject.sessions.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SessionCard(session: subject.sessions[index], subject: subject),
                      ),
          ),
        ),
      );
}
