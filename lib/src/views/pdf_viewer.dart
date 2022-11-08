import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' show File;
import 'package:flutter_cache_manager/flutter_cache_manager.dart' show DefaultCacheManager;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_render/pdf_render_widgets.dart' show PdfViewer, PdfViewerController;
import 'package:printing/printing.dart' show Printing;

import '../models.dart' show PDFType;
import '../services/api.dart' show APIService;
import 'error.dart' show ErrorView;

class PDFViewerView extends StatefulHookWidget {
  const PDFViewerView({Key? key, this.paper, this.url, this.type, this.title}) : super(key: key);

  static const routeName = '/pdf';

  final String? paper, url, title;
  final PDFType? type;

  @override
  State<PDFViewerView> createState() => _PDFViewerViewState();
}

class _PDFViewerViewState extends State<PDFViewerView> {
  final pfdViewerController = PdfViewerController();

  @override
  void dispose() {
    pfdViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileType = widget.type == PDFType.qs ? 'question_paper' : 'mark_scheme';

    final pageNumberController =
        useTextEditingController(text: pfdViewerController.currentPageNumber.toString());

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
            title: Text(widget.paper!), subtitle: Text(widget.title!), textColor: Colors.white),
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () =>
                APIService().downloadPDFFile(widget.url!, '${widget.paper}_$fileType.pdf').then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('File has been downloaded.')),
                      ),
                    ),
          ),
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () async {
              final response = await http.get(Uri.parse(widget.url!));

              await Printing.layoutPdf(onLayout: (_) => response.bodyBytes);
            },
          ),
        ],
      ),
      body: FutureBuilder<File>(
        future: DefaultCacheManager().getSingleFile(widget.url!),
        builder: (_, snapshot) => snapshot.hasData
            ? PdfViewer.openFile(
                snapshot.data!.path,
                viewerController: pfdViewerController,
              )
            : snapshot.hasError
                ? ErrorView(error: snapshot.error!, stackTrace: snapshot.stackTrace)
                : const Center(child: CircularProgressIndicator.adaptive()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Go to Page Number'),
            content: TextField(controller: pageNumberController),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => pfdViewerController
                    .goToPage(
                      pageNumber: int.parse(pageNumberController.text),
                    )
                    .then((_) => Navigator.of(context).pop()),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
        isExtended: true,
        child: ValueListenableBuilder(
          valueListenable: pfdViewerController,
          builder: (_, value, child) => Text(
            pfdViewerController.isReady
                ? '${pfdViewerController.currentPageNumber} / ${pfdViewerController.pageCount}'
                : '-',
          ),
        ),
      ),
    );
  }
}
