class TokenInfo {
  String? token;
  String? expires;

  TokenInfo({
    this.token,
    this.expires,
  });

  TokenInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'expires': expires,
  };
}