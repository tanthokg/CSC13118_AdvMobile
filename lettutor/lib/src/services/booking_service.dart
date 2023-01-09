import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/schedule/schedule.dart';

class BookingService {
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  static Future<List<Schedule>> getTutorScheduleById({
    required String token,
    required String userId,
  }) async {
    final response = await post(Uri.parse('$baseUrl/schedule'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'tutorId': userId,
    });

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }

    final schedules = jsonDecode['data'] as List;
    return schedules.map((schedule) => Schedule.fromJson(schedule)).toList();
  }

  static Future<void> bookClass({
    required List<String> scheduleDetailIds,
    required String note,
    required String token,
  }) async {
    final response = await post(
      Uri.parse('$baseUrl/booking'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'scheduleDetailIds': scheduleDetailIds,
          'note': note,
        },
      ),
    );

    if (response.statusCode != 200) {
      final jsonDecode = json.decode(response.body);
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<String> cancelBookedClass({
    required List<String> scheduleDetailIds,
    required String token,
  }) async {
    final response = await delete(
      Uri.parse('$baseUrl/booking'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'scheduleDetailIds': scheduleDetailIds,
        },
      ),
    );

    if (response.statusCode != 200) {
      return json.decode(response.body)['message'];
    }
    return "Class Cancelled Successfully";
  }
}
