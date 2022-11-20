import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' show DefaultCacheManager;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../models.dart' show PDFType;
import '../services/api.dart' show APIService;
import '../utils.dart' show printPdf;
import 'error.dart';

/// The widget for the pdf viewer.
class PDFView extends StatefulHookWidget {
  ///
  const PDFView({super.key, this.name, this.url, this.type});

  /// The route of this view.
  static const routeName = '/pdf';

  /// The name of the paper.
  final String? name;

  /// The url that will be given to the viewer.
  final String? url;

  /// This determines whether it is a question paper or a mark scheme.
  final PDFType? type;

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  final controller = PdfViewerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onPopupMenuSelected(int value) {
    switch (value) {
      case 0:
        printPdf(widget.url!);
        return;
      case 1:
        APIService()
            .downloadPDFFile(
              widget.url!,
              widget.name!,
              widget.type!,
            )
            .whenComplete(
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('File has been successfully downloaded.'),
                ),
              ),
            );
        return;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pdfHasError = useState(false);
    final pdfError = useState<Object?>(null);

    void onViewerError(Object? error) {
      pdfHasError.value = true;
      pdfError.value = error;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
        leading: const BackButton(color: Colors.white),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: onPopupMenuSelected,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0, child: Text('Print')),
              const PopupMenuItem(value: 1, child: Text('Download')),
            ],
          ),
        ],
      ),
      body: pdfHasError.value
          ? ErrorView(error: pdfError.value ?? '')
          : FutureBuilder(
              future: DefaultCacheManager().getSingleFile(widget.url!),
              builder: (context, snapshot) => snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: PdfViewer.openFile(
                        snapshot.data!.path,
                        viewerController: controller,
                        params: const PdfViewerParams(minScale: 0.05),
                        onError: onViewerError,
                      ),
                    )
                  : const Center(child: CircularProgressIndicator.adaptive()),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        isExtended: true,
        child: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) => Text(
            controller.isReady ? '${controller.currentPageNumber}/${controller.pageCount}' : '-',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
