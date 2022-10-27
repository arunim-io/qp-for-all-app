import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:qp_for_all/src/modules/subject/models.dart' show Subject;

var dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

Future<List<Subject>> getSubjects(String? curriculum, String? qualification) async {
  final response = await dio.get(
    '/subjects/',
    queryParameters: {'curriculum': curriculum ?? '', 'qualification': qualification ?? ''},
  );
  return (response.data as List)
      .map<Subject>((subject) => Subject.convertFromJSON(subject))
      .toList();
}

Future<Subject> getSubject(int id, String? curriculum, String? qualification) async {
  final response = await dio.get('/subjects/$id/');
  return Subject.convertFromJSON(response.data);
}
