import 'dart:developer' show log;

import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;

import '../models.dart' show PDFType, Subject;
import '../utils.dart' show getDownloadPath;

/// A service that uses dio to connect to the server and fetch data.
class APIService {
  final _dio = Dio(BaseOptions(baseUrl: 'http://192.168.0.9:8000/api'));

  /// Initializes the service.
  void initialize() {
    _dio.interceptors.add(
      PrettyDioLogger(logPrint: (object) => log(object.toString())),
    );
  }

  /// Connects to the server and fetches data i.e a list of subjects.
  Future<List<Subject>> getSubjects(String? query) async {
    final response = await _dio.get<dynamic>('/subjects/', queryParameters: {'query': query});

    return (response.data as List)
        .map<Subject>(
          (subject) => Subject.fromJson(subject as Map<String, dynamic>),
        )
        .toList();
  }

  /// Connects to the server and fetches data i.e a subject.
  Future<Subject> getSubject(
    int id,
    String? curriculum,
    String? qualification,
    String? query,
  ) async {
    final response = await _dio.get<dynamic>(
      '/subjects/$id/',
      queryParameters: {
        'curriculum': curriculum,
        'qualification': qualification,
        'query': query,
      },
    );

    return Subject.fromJson(response.data as Map<String, dynamic>);
  }

  /// Connects to the server and fetches a PDF file.
  Future<void> downloadPDFFile(String url, String name, PDFType type) async {
    final directory = await getDownloadPath();
    final fileType = type == PDFType.qs ? 'question_paper' : 'mark_scheme';

    try {
      await _dio.download(url, '$directory/${name}_$fileType.pdf');
    } catch (error, stackTrace) {
      log('ERROR', error: error, stackTrace: stackTrace);
      throw Exception('Unable to download file');
    }
  }
}

/// A class representing the query parameters that are used during API calls.
class SubjectQuery extends Equatable {
  ///
  const SubjectQuery({required this.id, this.curriculum, this.qualification});

  /// current id of the subject
  final int id;

  /// current curriculum
  final String? curriculum;

  /// current qualification
  final String? qualification;

  @override
  List<Object?> get props => [id, curriculum, qualification];
}
