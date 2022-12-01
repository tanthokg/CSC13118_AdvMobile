import 'package:flutter/material.dart';
import 'package:lettutor/src/models/user/token.dart';
import 'package:lettutor/src/models/user/user.dart';

class AuthProvider extends ChangeNotifier {
  late User currentUser;
  Token? token;

  void setUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  void logIn(User user, Token token) {
    currentUser = user;
    this.token = token;
    notifyListeners();
  }

  void logOut() {
    token = null;
    notifyListeners();
  }
}