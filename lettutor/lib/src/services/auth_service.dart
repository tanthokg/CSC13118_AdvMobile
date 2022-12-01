import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/src/models/user/token.dart';
import 'package:lettutor/src/models/user/user.dart';
import 'package:lettutor/src/providers/auth_provider.dart';

class AuthService {
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  static User parseUser(String responseBody) =>
      User.fromJson(jsonDecode(responseBody));

  static Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required AuthProvider authProvider,
    required Function(User, Token, AuthProvider) callback,
  }) async {
    final response = await post(
      Uri.parse("$baseUrl/auth/login"),
      body: {
        'email': email,
        'password': password,
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final user = User.fromJson(jsonDecode['user']);
    final token = Token.fromJson(jsonDecode['tokens']);
    await callback(user, token, authProvider);
  }

  static Future<void> authenticate({
    required String refreshToken,
    required AuthProvider authProvider,
    required Function(User, Token, AuthProvider) callback,
  }) async {
    final response = await post(
      Uri.parse("$baseUrl/auth/refresh-token"),
      body: {
        'refreshToken': refreshToken,
        'timezone': "7",
      },
    );

    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final user = User.fromJson(jsonDecode['user']);
    final token = Token.fromJson(jsonDecode['tokens']);
    await callback(user, token, authProvider);
  }
}
