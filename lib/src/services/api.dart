import 'package:dio/dio.dart' show BaseOptions, Dio;

import '../models.dart' show Subject;

/// A service that uses dio to connect to the server and fetch data.
class APIService {
  final _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<List<Subject>> getSubjects(String? query) async {
    final response = await _dio.get('/subjects/', queryParameters: {'query': query});

    return (response.data as List)
        .map<Subject>((subject) => Subject.convertFromJSON(subject))
        .toList();
  }

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
}
