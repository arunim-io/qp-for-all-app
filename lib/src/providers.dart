import 'package:hooks_riverpod/hooks_riverpod.dart' show FutureProvider, StateProvider;

import 'services/api.dart' show APIService, SubjectQuery;

final _api = APIService();

/// [FutureProvider] instance for subjects.
final subjectsProvider = FutureProvider.autoDispose(
  (ref) => _api.getSubjects(ref.watch(subjectSearchProvider)),
  name: 'subjects',
);

/// [FutureProvider] instance for subject with a [SubjectQuery] query parameter.
final subjectProvider = FutureProvider.autoDispose.family(
  (ref, SubjectQuery query) => _api.getSubject(
    query.id,
    query.curriculum,
    query.qualification,
    ref.watch(sessionSearchProvider),
  ),
  name: 'subject',
);

/// StateProvider instance for search bar in HomeView.
final subjectSearchProvider = StateProvider((_) => '', name: 'subjectSearch');

/// StateProvider instance for search bar in SubjectView.
final sessionSearchProvider = StateProvider((_) => '', name: 'sessionSearch');
