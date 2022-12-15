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

  // static Future<BookingInfo?> fetchNextLesson(String token) async {
  //   final dateTime = DateTime.now().millisecondsSinceEpoch;
  //   final response = await get(
  //     Uri.parse('$baseUrl/booking/next?dateTime=$dateTime'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final jsonRes = json.decode(response.body);
  //     final listData = jsonRes["data"] as List;
  //     List<BookingInfo> arrLesson = listData.map((e) => BookingInfo.fromJson(e)).toList();
  //     arrLesson.sort(
  //             (a, b) => a.!.startPeriodTimestamp.compareTo(b.scheduleDetailInfo!.startPeriodTimestamp));
  //
  //     arrLesson = arrLesson.where((element) => element.scheduleDetailInfo!.startPeriodTimestamp > dateTime).toList();
  //     if (arrLesson.isEmpty) {
  //       return null;
  //     } else {
  //       return arrLesson.first;
  //     }
  //   } else {
  //     throw Exception(json.decode(response.body)["message"]);
  //   }
  // }
}
