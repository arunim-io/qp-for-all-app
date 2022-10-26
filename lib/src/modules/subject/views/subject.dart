import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart' show Subject;
import '../providers.dart' show subjectProvider;
import '../widgets/session_list.dart' show SessionListWidget;

class SubjectView extends ConsumerWidget {
  const SubjectView({super.key, this.id});

  final int? id;

  static const routeName = '/subject';

  Widget view(Subject subject) => DefaultTabController(
        length: subject.qualifications.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(subject.name),
            bottom: subject.qualifications.length != 1
                ? TabBar(tabs: subject.qualifications.map((e) => Tab(text: e)).toList())
                : null,
          ),
          body: subject.sessions.isEmpty
              ? const Center(child: Text('Nothing to show'))
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: TabBarView(
                    children: subject.qualifications
                        .map((e) => SessionListWidget(qualification: e, subject: subject))
                        .toList(),
                  ),
                ),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(subjectProvider(id!)).when(
        data: (data) => view(data),
        error: (error, stackTrace) => Center(
          child: Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      );
}
