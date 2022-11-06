import 'dart:developer' show log;

import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.error, required this.stackTrace}) : super(key: key);

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    log("ERROR", error: error, stackTrace: stackTrace);

    return const Center(
      child: Text(
        'An error occurred. Please try again later',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
