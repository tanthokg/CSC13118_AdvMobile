import 'package:lettutor/src/models/user/token_info.dart';

class Token {
  TokenInfo? access;
  TokenInfo? refresh;

  Token.fromJson(Map<String, dynamic> json) {
    access = TokenInfo.fromJson(json['access']);
    refresh = TokenInfo.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() => {
        'access': access?.toJson(),
        'refresh': refresh?.toJson(),
      };
}
