import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' show File;
import 'package:flutter_cache_manager/flutter_cache_manager.dart' show DefaultCacheManager;
import 'package:pdf_render/pdf_render_widgets.dart' show PdfViewer;
import 'package:qp_for_all/src/models.dart';
import 'package:qp_for_all/src/services/api.dart';

import 'error.dart' show ErrorView;

class PDFViewerView extends StatelessWidget {
  const PDFViewerView({Key? key, this.paper, this.url, this.type, this.title}) : super(key: key);

  static const routeName = '/pdf';

  final String? paper, url, title;
  final PDFType? type;

  @override
  Widget build(BuildContext context) {
    final fileType = type == PDFType.qs ? 'question_paper' : 'mark_scheme';

    return Scaffold(
      appBar: AppBar(
        title: ListTile(title: Text(paper!), subtitle: Text(title!), textColor: Colors.white),
        leading: const BackButton(color: Colors.white),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Download')),
              const PopupMenuItem<int>(value: 1, child: Text('Open with')),
              const PopupMenuItem<int>(value: 2, child: Text('PDF details')),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  APIService().downloadPDFFile(url!, '${paper}_$fileType.pdf').then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('File has been downloaded.')),
                        ),
                      );
              }
            },
          ),
        ],
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
