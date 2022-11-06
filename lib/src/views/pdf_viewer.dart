import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PDFViewerView extends ConsumerWidget {
  const PDFViewerView({Key? key, this.paper, this.url}) : super(key: key);

  static const routeName = '/pdf-viewer';

  final String? paper, url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paper!),
        leading: const BackButton(color: Colors.white),
      ),
      body: Center(child: Text(url!)),
    );
  }
}
