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

/// A Widget that display a pdf reader.
class PDFViewerView extends StatefulHookWidget {
  ///
  const PDFViewerView({super.key, this.title, this.name, this.url, this.type});

  /// The route of this view.
  static const routeName = '/pdf';

  /// whether it is a question paper or a mark scheme
  final PDFType? type;

  /// title of the widget.
  final String? title;

  /// link to the pdf document.
  final String? url;

  /// name of the paper.
  final String? name;

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

  Future<void> printPdf() async {
    final response = await http.get(Uri.parse(widget.url!));

    await Printing.layoutPdf(onLayout: (_) => response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    final pageNumberController = useTextEditingController(
      text: pfdViewerController.currentPageNumber.toString(),
    );

    void download() {
      // ignore: lines_longer_than_80_chars
      final fileType = widget.type == PDFType.qs ? 'question_paper' : 'mark_scheme';
      const snackBar = SnackBar(
        content: Text('File has been downloaded.'),
      );

      APIService()
          .downloadPDFFile(widget.url!, '${widget.name}_$fileType.pdf')
          .then((_) => ScaffoldMessenger.of(context).showSnackBar(snackBar));
    }

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(widget.name!),
          subtitle: Text(widget.title!),
          textColor: Colors.white,
        ),
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: download,
          ),
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: printPdf,
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
                ? ErrorView(
                    error: snapshot.error!,
                    stackTrace: snapshot.stackTrace,
                  )
                : const Center(child: CircularProgressIndicator.adaptive()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<void>(
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
