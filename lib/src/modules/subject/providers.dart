import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qp_for_all/src/config/api.dart' show getSubject, getSubjects;

final subjectsProvider = FutureProvider.autoDispose.family(
  (_, String curriculum) => getSubjects(curriculum),
  name: 'subjects',
);

final subjectProvider = FutureProvider.autoDispose.family(
  (_, int id) => getSubject(id),
  name: 'subject',
);
