import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';

class TutorService {
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  static Future<List<Tutor>> getListTutorWithPagination({
    required int page,
    required int perPage,
    required String token,
  }) async {
    final response = await get(
      Uri.parse('$baseUrl/tutor/more?perPage=$perPage&page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> tutors = jsonDecode['tutors']['rows'];
    // print(tutors);
    // return [];
    return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
  }

  static Future<List<Tutor>> searchTutor({
    required int page,
    required int perPage,
    required String token,
    String search = '',
    List<String> specialties = const [],
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/tutor/search'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json;encoding=utf-8',
      },
      body: json.encode({
        'page': page,
        'perPage': perPage,
        'search': search,
        'filters': {
          'specialties': specialties,
        },
      }),
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    
    final List<dynamic> tutors = jsonDecode['rows'];
    return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
  }
}
