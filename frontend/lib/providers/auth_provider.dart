import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/services/storage/key_value_storage.dart';

class AuthProvider with ChangeNotifier {
  User? user;
  bool isLoggin = false;

  final String _authKey = "auth_key";

  AuthProvider() {
    (() async {
      await loadUser();
    })();
  }

  Future<void> loadUser() async {
    String? json = await KeyJsonStorage.get(_authKey);
    if (json == null) {
      return;
    }
    user = User.mapToObject(jsonDecode(json));
    isLoggin = true;
    notifyListeners();
  }

  Future<void> signin(String fullname, String accessToken) async {
    user = User(fullname: fullname, accessToken: accessToken);
    isLoggin = true;
    await KeyJsonStorage.set(_authKey, jsonEncode(User.toMap(user!)));
    notifyListeners();
  }

  Future<void> logoff() async {
    user = null;
    isLoggin = false;
    await KeyJsonStorage.clear(_authKey);
    notifyListeners();
  }
}
