import 'package:equatable/equatable.dart' show Equatable;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'models.g.dart';

@JsonSerializable()
class Subject extends Equatable {
  const Subject(
    this.id,
    this.name,
    this.curriculums,
    this.qualifications,
    this.sessions,
    this.papers,
  );

  factory Subject.fromJson(Map<String, dynamic> data) => _$SubjectFromJson(data);

  final int id;
  final String name;
  final List<String> curriculums;
  final List<String> qualifications;
  final List<Session> sessions;
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

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

@JsonSerializable()
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

  factory Paper.fromJson(Map<String, dynamic> data) => _$PaperFromJson(data);

  final int id;
  final String title, subject, curriculum, qualification, session, qpUrl, msUrl;

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

  Map<String, dynamic> toJson() => _$PaperToJson(this);
}

@JsonSerializable()
class Session extends Equatable {
  const Session(this.id, this.name);

  factory Session.fromJson(Map<String, dynamic> data) => _$SessionFromJson(data);

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

enum PDFType { ms, qs }
