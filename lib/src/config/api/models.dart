import 'package:equatable/equatable.dart' show Equatable;

enum Curriculum { EDEXCEL, CAMBRIDGE }

enum Qualification { IGCSE, IAS, IA2 }

class Subject extends Equatable {
  const Subject(
    this.id,
    this.name,
    this.curriculums,
    this.qualifications,
    this.sessions,
    this.papers,
  );

  final int id;
  final String name;
  final List<dynamic> curriculums;
  final List<dynamic> qualifications;
  final List<dynamic> sessions;
  final List<dynamic> papers;

  @override
  List<Object?> get props => [
        id,
        name,
        curriculums,
        qualifications,
        sessions,
        papers,
      ];

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Subject.convertFromJSON(Map<String, dynamic> data) => Subject(
        data['id'],
        data['name'],
        data['curriculums'],
        data['qualifications'],
        data['sessions'],
        data['papers'],
      );
}

class Paper extends Equatable {
  const Paper(
    this.id,
    this.title,
    this.subject,
    this.curriculum,
    this.qualification,
    this.session,
    this.qpUrl,
    this.msUrl,
  );

  final int id;
  final String title, subject, curriculum, qualification, session, qpUrl, msUrl;

  @override
  List<Object?> get props => [
        id,
        title,
        subject,
        curriculum,
        qualification,
        session,
        qpUrl,
        msUrl,
      ];

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Paper.convertFromJSON(Map<String, dynamic> data) => Paper(
        data['id'],
        data['title'],
        data['subject'],
        data['curriculum'],
        data['qualification'],
        data['session'],
        data['qp_url'],
        data['ms_url'],
      );
}

class Session extends Equatable {
  const Session(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Session.convertFromJSON(Map<String, dynamic> data) => Session(
        data['id'],
        data['name'],
      );
}
