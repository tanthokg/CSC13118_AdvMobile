import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/schedule/schedule.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';
import 'package:lettutor/src/models/tutor/tutor_info.dart';
import 'package:lettutor/src/models/user/learn_topic.dart';
import 'package:lettutor/src/models/user/test_preparation.dart';

class TutorService {
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  static Future<List<LearnTopic>> getTopics() async {
    return <LearnTopic>[];
  }

  static Future<List<TestPreparation>> getTestPreparations() async {
    return <TestPreparation>[];
  }

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

  static Future<TutorInfo> getTutorInfoById({
    required String token,
    required String userId,
  }) async {
    final response = await get(
      Uri.parse('$baseUrl/tutor/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    return TutorInfo.fromJson(jsonDecode);
  }

  static Future<Map<String, dynamic>> searchTutor({
    required String token,
    String search = '',
    required int page,
    required int perPage,
    required Map<String, bool> nationality,
    required List<String> specialties,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/tutor/search'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'page': page,
        'perPage': perPage,
        'search': search,
        'filters': {
          'specialties': specialties,
          'nationality': nationality,
        },
      }),
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> tutors = jsonDecode['rows'];

    return {
      'count': jsonDecode['count'],
      'tutors': tutors.map((tutor) => Tutor.fromJson(tutor)).toList(),
    };
  }

  static Future<void> addTutorToFavorite({
    required String token,
    required String userId,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/user/manageFavoriteTutor'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': userId,
        },
      ),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<void> reportTutor({
    required String token,
    required String userId,
    required String content,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/report'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': userId,
          'content': content,
        },
      ),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }
  }
}
