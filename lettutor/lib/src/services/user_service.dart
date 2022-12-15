import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';

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

  static Future<List<BookingInfo>> getUpcomingClasses({
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
    return classes.map((schedule) => BookingInfo.fromJson(schedule)).toList();
  }
}
