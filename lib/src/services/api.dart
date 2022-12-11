import 'dart:developer' show log;

import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart' show RetryInterceptor;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;

import '../models.dart' show PDFType, Subject;
import '../utils.dart' show getCacheDirectory, getDownloadPath;

/// A service that uses [Dio] to connect to the server and fetch data.
class APIService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://qp-for-all-api.fly.dev/api'));

  /// Initializes the service.
  Future<void> initialize() async {
    final directory = await getCacheDirectory();

    _dio.interceptors.addAll([
      PrettyDioLogger(),
      RetryInterceptor(dio: _dio),
      DioCacheInterceptor(
        options: CacheOptions(store: HiveCacheStore(directory)),
      )
    ]);
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
