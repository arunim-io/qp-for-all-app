import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qp_for_all/src/modules/subject/models/subject.dart';

final subjectsProvider = Provider((ref) => Subject.list, name: 'Products');

final subjectProvider = Provider.family(
  (ref, int id) => ref.watch(subjectsProvider)[id],
  name: 'Product',
);
