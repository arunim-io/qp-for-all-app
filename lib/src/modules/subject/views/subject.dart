import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart' show Subject;
import '../provider.dart' show subjectProvider;
import '../widgets/session_list.dart' show SessionListWidget;

class SubjectView extends ConsumerWidget {
  const SubjectView({super.key, this.id});

  final String? id;

  static const routeName = '/subject';

  Widget view(Subject subject) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(subject.name),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'IGSCE'),
                Tab(text: 'AS'),
                Tab(text: 'A2'),
              ],
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(10),
            child: TabBarView(
              children: [
                SessionListWidget(qualification: 'IGSCE'),
                SessionListWidget(qualification: 'AS'),
                SessionListWidget(qualification: 'A2'),
              ],
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
