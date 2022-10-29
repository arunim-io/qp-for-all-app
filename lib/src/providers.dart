import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show FutureProvider;

import 'services/api.dart' show APIService;

final api = APIService();

class SubjectQuery extends Equatable {
  const SubjectQuery({required this.id, this.curriculum, this.qualification});

  final String? curriculum, qualification;
  final int id;

  @override
  List<Object?> get props => [id, curriculum, qualification];
}

final subjectsProvider = FutureProvider.autoDispose(
  (_) => api.getSubjects(),
  name: 'subjects',
);

final subjectProvider = FutureProvider.autoDispose.family(
  (_, SubjectQuery query) => api.getSubject(query.id, query.curriculum, query.qualification),
  name: 'subject',
);
