import 'package:equatable/equatable.dart' show Equatable;

class Subject extends Equatable {
  const Subject(this.id, this.name, this.curriculums, this.qualifications, this.sessions);

  @override
  List<Object?> get props => [id, name, curriculums, qualifications];

  final String id;
  final String name;
  final List<dynamic> curriculums, qualifications;
  final List<Session>? sessions;

  /// A constructor, for constructing a new model instance from a Firestore response.
  factory Subject.fromFirestore(Map<String, dynamic>? data, String documentId) => Subject(
        documentId,
        data!['name'],
        data['curriculums'],
        data['qualifications'],
        data['sessions'],
      );
}

class Session extends Equatable {
  const Session(this.id, this.name);

  @override
  List<Object?> get props => [id, name];

  final String id;
  final String name;

  /// A constructor, for constructing a new model instance from a Firestore response.
  factory Session.fromFirestore(Map<String, dynamic>? data, String documentId) => Session(
        documentId,
        data!['name'],
      );
}
