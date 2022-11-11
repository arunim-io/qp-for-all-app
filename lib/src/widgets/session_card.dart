import 'package:flutter/material.dart';

import '../models.dart' show PDFType, Session, Subject;
import '../utils.dart' show navigate;
import '../views/pdf_view.dart' show PDFView;

/// A card that takes in a [Session].
///
/// It currently shows the name and
/// provides details to the papers under the current session & qualification.
class SessionCard extends StatelessWidget {
  ///
  const SessionCard({super.key, required this.session, required this.subject});

  /// Current subject
  final Subject subject;

  /// Current session
  final Session session;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2.5,
        child: Column(
          children: [
            ListTile(title: Text(session.name)),
            // ignore: avoid-shrink-wrap-in-lists
            ListView.builder(
              restorationId: 'PaperListView',
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subject.papers.length,
              itemBuilder: (context, index) {
                final paper = subject.papers[index];

                return Column(
                  children: subject.qualifications
                      .where((selected) => selected == paper.qualification)
                      .map(
                        (_) => ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${paper.qualification} - ${paper.title}'),
                              Row(
                                children: [
                                  TextButton(
                                    child: const Text('Question Paper'),
                                    onPressed: () => navigate(
                                      context,
                                      (_) => PDFView(
                                        name: paper.title,
                                        url: paper.qpUrl,
                                        type: PDFType.qs,
                                      ),
                                    ),
                                  ),
                                  const Text('-'),
                                  TextButton(
                                    child: const Text('Mark Scheme'),
                                    onPressed: () => navigate(
                                      context,
                                      (_) => PDFView(
                                        name: paper.title,
                                        url: paper.msUrl,
                                        type: PDFType.ms,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            )
          ],
        ),
      );
}
