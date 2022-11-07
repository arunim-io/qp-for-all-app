import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' show File;
import 'package:flutter_cache_manager/flutter_cache_manager.dart' show DefaultCacheManager;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf_render/pdf_render_widgets.dart' show PdfViewer;

import 'error.dart' show ErrorView;

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
      body: FutureBuilder<File>(
        future: DefaultCacheManager().getSingleFile(url!),
        builder: (context, snapshot) => snapshot.hasData
            ? PdfViewer.openFile(snapshot.data!.path)
            : snapshot.hasError
                ? ErrorView(error: snapshot.error!, stackTrace: snapshot.stackTrace)
                : const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
