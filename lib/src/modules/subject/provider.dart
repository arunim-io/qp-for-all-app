import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models.dart' show Subject;
import 'models/session.dart' show Session;

final subjectsProvider = StreamProvider.autoDispose(
  (_) => FirebaseFirestore.instance.collection('/subjects').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Subject.fromFirestore(doc.data(), doc.id)).toList()),
  name: 'subjects',
);

final subjectProvider = StreamProvider.autoDispose.family(
  (ref, String docId) => FirebaseFirestore.instance
      .collection('/subjects')
      .doc(docId)
      .snapshots()
      .map((snapshot) => Subject.fromFirestore(snapshot.data(), snapshot.id)),
  name: 'subject',
);

final sessionsProvider = Provider((_) => Session.list, name: 'Sessions');
