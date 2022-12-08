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
        "Content-Type": "application/json",
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
}
