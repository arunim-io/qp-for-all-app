import 'dart:developer';

import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;
import 'package:qp_for_all/src/utils.dart';

import '../models.dart' show Subject;

/// A service that uses dio to connect to the server and fetch data.
class APIService {
  final _dio = Dio(BaseOptions(baseUrl: 'http://192.168.0.9:8000/api'));

  /// Initializes the service.
  void initialize() {
    _dio.interceptors.add(PrettyDioLogger(logPrint: (object) => log(object.toString())));
  }

  /// Connects to the server and fetches data i.e a list of subjects.
  Future<List<Subject>> getSubjects(String? query) async {
    final response = await _dio.get('/subjects/', queryParameters: {'query': query});

    return (response.data as List)
        .map<Subject>((subject) => Subject.convertFromJSON(subject))
        .toList();
  }

  /// Connects to the server and fetches data i.e a subject.
  Future<Subject> getSubject(
    int id,
    String? curriculum,
    String? qualification,
    String? query,
  ) async {
    final response = await _dio.get(
      '/subjects/$id/',
      queryParameters: {"curriculum": curriculum, "qualification": qualification, 'query': query},
    );

    return Subject.convertFromJSON(response.data);
  }

  /// Connects to the server and fetches a PDF file.
  Future<String?> downloadPDFFile(String url, String file) async {
    final directory = await getDownloadPath();

    try {
      await _dio.download(url, '$directory/$file');
      return directory;
    } catch (error, stackTrace) {
      log('ERROR', error: error, stackTrace: stackTrace);
      throw Exception('Unable to download file');
    }
  }
}
