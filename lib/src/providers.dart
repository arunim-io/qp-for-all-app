import 'package:equatable/equatable.dart' show Equatable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show FutureProvider, StateProvider;

import 'services/api.dart' show APIService;

final _api = APIService();

class SubjectQuery extends Equatable {
  const SubjectQuery({required this.id, this.curriculum, this.qualification});

  final String? curriculum, qualification;
  final int id;

  @override
  List<Object?> get props => [id, curriculum, qualification];
}

final subjectsProvider = FutureProvider.autoDispose(
  (ref) => _api.getSubjects(ref.watch(subjectSearchProvider)),
  name: 'subjects',
);

final subjectProvider = FutureProvider.autoDispose.family(
  (ref, SubjectQuery query) => _api.getSubject(
    query.id,
    query.curriculum,
    query.qualification,
    ref.watch(sessionSearchProvider),
  ),
  name: 'subject',
);

final subjectSearchProvider = StateProvider((_) => '', name: 'subjectSearch');

final sessionSearchProvider = StateProvider((_) => '', name: 'sessionSearch');
