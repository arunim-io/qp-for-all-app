import 'package:flutter/material.dart';
import 'package:qp_for_all/src/modules/subject/models/subject.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({super.key, required this.subject});

  final Subject? subject;

  static const routeName = '/subject';

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('${subject?.name} Details'),
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
