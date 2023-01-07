import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';
import 'package:lettutor/src/models/user/learn_topic.dart';
import 'package:lettutor/src/models/user/test_preparation.dart';
import 'package:lettutor/src/models/user/user.dart';

class UserService {
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  static getTotalLessonTime(String token) async {
    final response = await get(
      Uri.parse('$baseUrl/call/total'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception('Error: Unable to get total lesson time');
    }

    return jsonDecode['total'];
  }

  static Future<BookingInfo> getUpcomingLesson(String token) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final response = await get(
      Uri.parse('$baseUrl/booking/next?dateTime=$now'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> data = jsonDecode['data'];
    List<BookingInfo> lessons = data.map((e) => BookingInfo.fromJson(e)).toList();

    // Sort lessons by timestamp increasingly
    lessons.sort((a, b) {
      if (a.scheduleDetailInfo == null || b.scheduleDetailInfo == null) return 0;
      if (a.scheduleDetailInfo!.startPeriodTimestamp == null ||
          b.scheduleDetailInfo!.startPeriodTimestamp == null) return 0;

      final int timestamp1 = a.scheduleDetailInfo!.startPeriodTimestamp!;
      final int timestamp2 = b.scheduleDetailInfo!.startPeriodTimestamp!;

      return timestamp1.compareTo(timestamp2);
    });

    lessons = lessons.where((element) {
      if (element.scheduleDetailInfo == null) return false;
      if (element.scheduleDetailInfo!.startPeriodTimestamp == null) return false;

      final int startTimestamp = element.scheduleDetailInfo!.startPeriodTimestamp!;
      return startTimestamp > now;
    }).toList();

    if (lessons.isNotEmpty) {
      return lessons.first;
    } else {
      throw Exception('Error: Cannot get next lesson info');
    }
  }

  static Future<Map<String, dynamic>> getAllUpcomingClasses({
    required String token,
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final response = await get(
      Uri.parse(
          '$baseUrl/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=asc'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Error: Cannot get upcoming classes. ${jsonDecode['message']}');
    }

    final List<dynamic> classes = jsonDecode['data']['rows'];
    return {
      'count': jsonDecode['data']['count'],
      'classes': classes.map((schedule) => BookingInfo.fromJson(schedule)).toList(),
    };
  }

  static Future<Map<String, dynamic>> getHistory({
    required String token,
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final response = await get(
      Uri.parse(
          '$baseUrl/booking/list/student?page=$page&perPage=$perPage&dateTimeLte=$now&orderBy=meeting&sortBy=desc'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Error: Cannot get history. ${jsonDecode['message']}');
    }

    final List<dynamic> classes = jsonDecode['data']['rows'];
    return {
      'count': jsonDecode['data']['count'],
      'classes': classes.map((schedule) => BookingInfo.fromJson(schedule)).toList()
    };
  }

  static Future<List<LearnTopic>> getLearningTopic(String token) async {
    final response = await get(
      Uri.parse('$baseUrl/learn-topic'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return jsonDecode.map((e) => LearnTopic.fromJson(e)).toList();
  }

  static Future<List<TestPreparation>> getTestPreparation(String token) async {
    final response = await get(
      Uri.parse('$baseUrl/test-preparation'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return jsonDecode.map((e) => TestPreparation.fromJson(e)).toList();
  }

  static Future<User?> getUserInfo(String token) async {
    final response = await get(
      Uri.parse('$baseUrl/user/info'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      return User.fromJson(jsonDecode['user']);
    }
  }

  static Future<User?> updateInfo({
    required String token,
    required String name,
    required String country,
    required String birthday,
    required String level,
    required List<String> learnTopics,
    required List<String> testPreparations,
    required String studySchedule,
  }) async {
    final response = await put(
      Uri.parse('$baseUrl/user/info'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': name,
        'country': country,
        'birthday': birthday,
        'level': level,
        'learnTopics': learnTopics,
        'testPreparations': testPreparations,
        'studySchedule': studySchedule,
      }),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    }
    return User.fromJson(jsonDecode['user']);
  }
}
