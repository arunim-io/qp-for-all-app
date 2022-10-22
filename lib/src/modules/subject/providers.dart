import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models.dart' show Session, Subject;

final subjectsProvider = StreamProvider.autoDispose.family(
  (_, String curriculum) => FirebaseFirestore.instance
      .collection('/subjects')
      .where('curriculums', arrayContains: curriculum)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Subject.fromFirestore(doc.data(), doc.id)).toList()),
  name: 'subjects',
);

final subjectProvider = StreamProvider.autoDispose.family(
  (_, String id) => FirebaseFirestore.instance
      .collection('/subjects')
      .doc(id)
      .snapshots()
      .map((snapshot) => Subject.fromFirestore(snapshot.data(), snapshot.id)),
  name: 'subject',
);

final sessionsStreamProvider = StreamProvider.autoDispose.family(
  (ref, String subjectId) => FirebaseFirestore.instance
      .collection('/subjects')
      .doc(subjectId)
      .collection('/sessions')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Session.fromFirestore(doc.data(), doc.id)).toList()),
  name: 'sessions',
);
