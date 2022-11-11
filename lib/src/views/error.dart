import 'dart:developer' show log;

import 'package:flutter/material.dart';

/// A widget that displays an error message when an error occurs.
class ErrorView extends StatelessWidget {
  ///
  const ErrorView({
    super.key,
    this.child,
    required this.error,
    this.stackTrace,
  });

  /// Widget to display.
  final Widget? child;

  /// The error
  final Object error;

  /// The stack trace
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    log('An error occurred.', error: error, stackTrace: stackTrace);

    return child ??
        const Center(
          child: Text(
            'An error occurred. Please try again later',
            style: TextStyle(color: Colors.red),
          ),
        );
  }
}
