import 'package:dio/dio.dart' show BaseOptions, Dio;

import 'models.dart' show Subject;

var dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

Future<List<Subject>> getSubjects(String curriculum) async {
  final response = await dio.get('/subjects', queryParameters: {'curriculum': curriculum});
  return (response.data as List)
      .map<Subject>((subject) => Subject.convertFromJSON(subject))
      .toList();
}

Future<Subject> getSubject(int id) async {
  final response = await dio.get('/subjects/$id');
  return Subject.convertFromJSON(response.data);
}
