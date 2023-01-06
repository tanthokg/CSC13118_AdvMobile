import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/course/course.dart';

class CourseService {
  static const String baseUrl = 'https://sandbox.api.lettutor.com';

  static Future<List<Course>> getListCourseWithPagination({
    required String token,
    required int page,
    required int size,
    required String search,
  }) async {
    final response = await get(
      Uri.parse('$baseUrl/course?page=$page&size=$size${search.isNotEmpty ? '&q=$search' : ''}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception('Error: Cannot get list of courses. ${jsonDecode['message']}');
    }

    final List<dynamic> courses = jsonDecode['data']['rows'];
    return courses.map((e) => Course.fromJson(e)).toList();
  }

  static Future<Course> getCourseDetailById(
      {required String token, required String courseId}) async {
    final response = await get(
      Uri.parse('$baseUrl/course/$courseId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception('Error: Cannot get course detail. ${jsonDecode['message']}');
    }

    return Course.fromJson(jsonDecode['data']);
  }

  // static Future<List<Course>> searchCourse({
  //   required String token,
  //   required int page,
  //   required int size,
  //   required String search,
  // }) async {
  //   final response = await get(
  //     Uri.parse('$baseUrl/course?page=$page&size=$size&q=$search'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   final jsonDecode = json.decode(response.body);
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Error: Cannot get list of courses. ${jsonDecode['message']}');
  //   }
  //
  //   final List<dynamic> courses = jsonDecode['data']['rows'];
  //   return courses.map((e) => Course.fromJson(e)).toList();
  // }
}
