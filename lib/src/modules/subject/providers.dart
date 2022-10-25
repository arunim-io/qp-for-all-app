import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qp_for_all/src/config/api/main.dart' show getSubject, getSubjects;

import 'models.dart' show Session, Subject, Paper;

final firestore = FirebaseFirestore.instance;

final subjectsProvider = FutureProvider.autoDispose.family(
  (_, String curriculum) => getSubjects(curriculum),
  name: 'subjects',
);

final subjectProvider = FutureProvider.autoDispose.family(
  (_, int id) => getSubject(id),
  name: 'subject',
);

final sessionsProvider = StreamProvider.autoDispose.family(
  (ref, String subjectId) => firestore
      .collection('/subjects')
      .doc(subjectId)
      .collection('/sessions')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Session.fromFirestore(doc.data(), doc.id)).toList()),
  name: 'sessions',
);

class PapersProviderParameters extends Equatable {
  const PapersProviderParameters({required this.subjectId, required this.sessionId});

  @override
  List<Object?> get props => [subjectId, sessionId];

  final String subjectId, sessionId;
}

final papersProvider = StreamProvider.autoDispose.family(
  (ref, PapersProviderParameters params) => firestore
      .collection('/subjects')
      .doc(params.subjectId)
      .collection('/sessions')
      .doc(params.sessionId)
      .collection('/papers')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Paper.fromFirestore(doc.data(), doc.id)).toList()),
  name: 'papers',
);
