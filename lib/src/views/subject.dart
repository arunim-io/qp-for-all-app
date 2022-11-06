import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart' show SubjectQuery, sessionSearchProvider, subjectProvider;
import '../widgets/search_bar.dart' show SearchBar;
import '../widgets/session_card.dart' show SessionCard;
import 'error.dart' show ErrorView;

class SubjectView extends ConsumerWidget {
  const SubjectView({Key? key, this.query, this.subjectName}) : super(key: key);

  static const routeName = '/subject';

  final SubjectQuery? query;
  final String? subjectName;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: Text(subjectName!),
          leading: const BackButton(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SearchBar(provider: sessionSearchProvider),
              const SizedBox(height: 25),
              ref.watch(subjectProvider(query!)).when(
                    error: (error, stackTrace) => ErrorView(error: error, stackTrace: stackTrace),
                    loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                    data: (subject) => subject.papers
                            .where((element) => element.curriculum == query!.curriculum)
                            .isEmpty
                        ? const Center(child: Text('Nothing to show'))
                        : Expanded(
                            child: ListView.builder(
                              restorationId: 'SessionListView',
                              itemCount: subject.sessions.length,
                              itemBuilder: (BuildContext context, int index) => SessionCard(
                                session: subject.sessions[index],
                                subject: subject,
                              ),
                            ),
                          ),
                  ),
            ],
          ),
        ),
      );
}
