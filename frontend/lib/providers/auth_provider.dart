import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/services/storage/storage.dart';

class AuthProvider with ChangeNotifier {
  User? user;
  bool isAuth = false;

  final String _authKey = "auth_key";

  Future<void> loadUser() {
    return Storage.getJson(_authKey).then((json) {
      if (json == null) {
        return;
      }
      user = User.mapToObject(jsonDecode(json));
      isAuth = true;
    });
  }

  Future<void> signin(String fullname, String accessToken) async {
    user = User(fullname: fullname, accessToken: accessToken);
    isAuth = true;
    await Storage.setJson(_authKey, jsonEncode(User.toMap(user!)));
    notifyListeners();
  }

  Future<void> logoff() async {
    user = null;
    isAuth = false;
    await Storage.clear(_authKey);
    notifyListeners();
  }
}
