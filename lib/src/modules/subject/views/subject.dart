import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart' show Subject;
import '../providers.dart' show subjectProvider;
import '../widgets/session_list.dart' show SessionListWidget;

class SubjectView extends ConsumerWidget {
  const SubjectView({super.key, this.id});

  final String? id;

  static const routeName = '/subject';

  Widget view(Subject subject) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(subject.name),
          bottom: subject.qualifications.length != 1
              ? const TabBar(
                  tabs: [
                    Tab(text: 'IGSCE'),
                    Tab(text: 'IAS'),
                    Tab(text: 'IA2'),
                  ],
                )
              : null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              SessionListWidget(qualification: 'IGSCE', subjectId: subject.id),
              SessionListWidget(qualification: 'IAS', subjectId: subject.id),
              SessionListWidget(qualification: 'IA2', subjectId: subject.id),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(subjectProvider(id!)).when(
        data: (data) => view(data),
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      );
}
