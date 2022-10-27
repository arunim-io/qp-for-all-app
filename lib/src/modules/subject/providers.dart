import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show FutureProvider;
import 'package:qp_for_all/src/config/api.dart' show getSubject, getSubjects;

class SubjectQuery extends Equatable {
  const SubjectQuery({required this.id, this.curriculum, this.qualification});

  final String? curriculum, qualification;
  final int id;

  @override
  List<Object?> get props => [id, curriculum, qualification];
}

final subjectsProvider = FutureProvider.autoDispose(
  (_) => getSubjects(),
  name: 'subjects',
);

final subjectProvider = FutureProvider.autoDispose.family(
  (_, SubjectQuery query) => getSubject(query.id, query.curriculum, query.qualification),
  name: 'subject',
);
