import 'package:equatable/equatable.dart' show Equatable;

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
  final List<String> curriculums;
  final List<String> qualifications;
  final List<Session> sessions;
  final List<Paper> papers;

  @override
  List<Object> get props => [id, name, curriculums, qualifications, sessions, papers];

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Subject.fromJson(Map<String, dynamic> data) => Subject(
        data['id'],
        data['name'],
        (data['curriculums'] as List).map((curriculum) => curriculum as String).toList(),
        (data['qualifications'] as List).map((qualification) => qualification as String).toList(),
        (data['sessions'] as List).map((session) => Session.fromJson(session)).toList(),
        (data['papers'] as List).map((paper) => Paper.fromJson(paper)).toList(),
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
  List<Object> get props => [id, title, subject, curriculum, qualification, session, qpUrl, msUrl];

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Paper.fromJson(Map<String, dynamic> data) => Paper(
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
  List<Object> get props => [id, name];

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Session.fromJson(Map<String, dynamic> data) => Session(data['id'], data['name']);
}

enum PDFType { ms, qs }
