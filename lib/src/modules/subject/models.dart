import 'package:equatable/equatable.dart' show Equatable;

class Subject extends Equatable {
  const Subject(
      this.id, this.name, this.availableIn, this.docId, this.curriculums, this.qualifications);

  @override
  List<Object?> get props => [id, name, availableIn];

  final int id;
  final String docId;
  final String name;
  final List<dynamic> availableIn, curriculums, qualifications;

  /// A constructor, for constructing a new model instance from a Firestore response.
  factory Subject.fromFirestore(Map<String, dynamic>? data, String documentId) => Subject(
        data!['id'],
        data['name'],
        data['available_in'],
        documentId,
        data['curriculums'],
        data['qualifications'],
      );
}
