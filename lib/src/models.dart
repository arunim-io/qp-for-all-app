import 'package:equatable/equatable.dart' show Equatable;

/// A class that represents a subject.
class Subject extends Equatable {
  ///
  const Subject(
    this.id,
    this.name,
    this.curriculums,
    this.qualifications,
    this.sessions,
    this.papers,
  );

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Subject.fromJson(Map<String, dynamic> data) => Subject(
        data['id'] as int,
        data['name'] as String,
        (data['curriculums'] as List).map((item) => item as String).toList(),
        (data['qualifications'] as List).map((item) => item as String).toList(),
        (data['sessions'] as List)
            .map<Session>(
              (item) => Session.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        (data['papers'] as List)
            .map<Paper>((item) => Paper.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  /// Subject id
  final int id;

  /// Subject name
  final String name;

  /// List of Subject curriculums
  final List<String> curriculums;

  /// List of Subject qualifications
  final List<String> qualifications;

  /// List of Subject sessions
  final List<Session> sessions;

  /// List of Subject papers
  final List<Paper> papers;

  @override
  List<Object> get props => [
        id,
        name,
        curriculums,
        qualifications,
        sessions,
        papers,
      ];
}

/// A class that represents a examination paper.
class Paper extends Equatable {
  ///
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

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Paper.fromJson(Map<String, dynamic> data) => Paper(
        data['id'] as int,
        data['title'] as String,
        data['subject'] as String,
        data['curriculum'] as String,
        data['qualification'] as String,
        data['session'] as String,
        data['qp_url'] as String,
        data['ms_url'] as String,
      );

  /// Paper id
  final int id;

  /// Name of the paper
  final String title;

  /// the subject related to the paper
  final String subject;

  /// the curriculum related to the paper
  final String curriculum;

  /// the qualification related to the paper
  final String qualification;

  /// the session of paper
  final String session;

  /// the link to the question of the paper
  final String qpUrl;

  /// the link to the mark scheme of the paper
  final String msUrl;

  @override
  List<Object> get props => [
        id,
        title,
        subject,
        curriculum,
        qualification,
        session,
        qpUrl,
        msUrl,
      ];
}

/// A class that represents a examination session.
class Session extends Equatable {
  ///
  const Session(this.id, this.name);

  /// A constructor, for constructing a new model instance from a JSON response.
  factory Session.fromJson(Map<String, dynamic> data) =>
      Session(data['id'] as int, data['name'] as String);

  /// Session id
  final int id;

  /// Session name
  final String name;

  @override
  List<Object> get props => [id, name];
}

/// Type of [Paper]
enum PDFType {
  /// is it a mark scheme?
  ms,

  /// is it question paper?
  qs,
}
