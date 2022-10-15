import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qp_for_all/src/modules/subject/provider.dart';

class SubjectView extends ConsumerWidget {
  const SubjectView({super.key, this.id});

  final int? id;

  static const routeName = '/subject';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subject = ref.watch(subjectProvider(id!));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${subject.name} Details'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'IGSCE O-Levels'),
              Tab(text: 'AS A-Levels'),
              Tab(text: 'A2 A-Levels'),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10),
          child: TabBarView(
            children: [
              Center(child: Text('IGCSE Papers')),
              Center(child: Text('AS Papers')),
              Center(child: Text('A2 Papers')),
            ],
          ),
        ),
      ),
    );
  }
}
