// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      json['id'] as int,
      json['name'] as String,
      (json['curriculums'] as List<dynamic>).map((e) => e as String).toList(),
      (json['qualifications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['sessions'] as List<dynamic>)
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['papers'] as List<dynamic>)
          .map((e) => Paper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'curriculums': instance.curriculums,
      'qualifications': instance.qualifications,
      'sessions': instance.sessions,
      'papers': instance.papers,
    };

Paper _$PaperFromJson(Map<String, dynamic> json) => Paper(
      json['id'] as int,
      json['title'] as String,
      json['subject'] as String,
      json['curriculum'] as String,
      json['qualification'] as String,
      json['session'] as String,
      json['qpUrl'] as String,
      json['msUrl'] as String,
    );

Map<String, dynamic> _$PaperToJson(Paper instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subject': instance.subject,
      'curriculum': instance.curriculum,
      'qualification': instance.qualification,
      'session': instance.session,
      'qpUrl': instance.qpUrl,
      'msUrl': instance.msUrl,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      json['id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
