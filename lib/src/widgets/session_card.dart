import 'package:flutter/material.dart';

import '../models.dart' show PDFType, Session, Subject;
import '../utils.dart' show navigate;
import '../views/pdf_viewer.dart' show PDFViewerView;

class SessionCard extends StatelessWidget {
  const SessionCard({Key? key, required this.session, required this.subject}) : super(key: key);

  final Subject subject;
  final Session session;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2.5,
        child: Column(
          children: [
            ListTile(title: Text(session.name)),
            ListView.builder(
              restorationId: 'PaperListView',
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
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
                                      (_) => PDFViewerView(
                                        paper: paper.title,
                                        url: paper.qpUrl,
                                        type: PDFType.qs,
                                        title: 'Question Paper',
                                      ),
                                    ),
                                  ),
                                  const Text('-'),
                                  TextButton(
                                    child: const Text('Mark Scheme'),
                                    onPressed: () => navigate(
                                      context,
                                      (_) => PDFViewerView(
                                        paper: paper.title,
                                        url: paper.msUrl,
                                        type: PDFType.ms,
                                        title: 'Mark Scheme',
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
