import 'package:flutter/material.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key, required this.curriculum});

  final String curriculum;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: curriculum == 'Edexcel' ? const Text('Edexcel') : const Text('Cambridge'),
    );
  }
}
