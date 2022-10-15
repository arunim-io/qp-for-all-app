import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import 'models/session.dart' show Session;
import 'models/subject.dart' show Subject;

final subjectsProvider = Provider((ref) => Subject.list, name: 'Products');

final subjectProvider = Provider.family(
  (ref, int id) => ref.watch(subjectsProvider)[id],
  name: 'Product',
);

final sessionsProvider = Provider((ref) => Session.list, name: 'Sessions');
