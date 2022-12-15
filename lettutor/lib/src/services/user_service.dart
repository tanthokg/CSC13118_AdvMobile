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
    final dateTime = DateTime.now().millisecondsSinceEpoch;
    final response = await get(
      Uri.parse('$baseUrl/booking/next?dateTime=$dateTime'),
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
      return startTimestamp > dateTime;
    }).toList();

    if (lessons.isNotEmpty) {
      return lessons.first;
    } else {
      throw Exception('Error: Cannot get next lesson info');
    }
  }
}
