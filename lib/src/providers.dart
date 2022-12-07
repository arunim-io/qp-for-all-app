import 'package:hooks_riverpod/hooks_riverpod.dart' show StateProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models.dart' show Subject;
import 'services/api.dart' show APIService, SubjectQuery;

part 'providers.g.dart';

final _api = APIService();

/// A [StateProvider] instance for search bar in HomeView.
final subjectSearchProvider = StateProvider((_) => '', name: 'subjectSearch');

/// A [StateProvider] instance for search bar in SubjectView.
final sessionSearchProvider = StateProvider((_) => '', name: 'sessionSearch');

/// A provider for subjects.
@riverpod
FutureOr<List<Subject>> subjects(SubjectsRef ref) {
  final search = ref.watch(subjectSearchProvider);

  return _api.getSubjects(search);
}

/// A provider for subject.
@riverpod
FutureOr<Subject> subject(SubjectRef ref, {required SubjectQuery query}) {
  return _api.getSubject(
    query.id,
    query.curriculum,
    query.qualification,
    ref.watch(sessionSearchProvider),
  );
}
