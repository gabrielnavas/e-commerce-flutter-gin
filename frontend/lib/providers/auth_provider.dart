import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/services/storage/key_value_storage.dart';

class AuthProvider with ChangeNotifier {
  User? user;
  bool isAuth = false;

  final String _authKey = "auth_key";

  // AuthProvider() {
  //   (() async {
  //     await loadUser();
  //   })();
  // }

  Future<void> loadUser() {
    return KeyJsonStorage.get(_authKey).then((json) {
      if (json == null) {
        return;
      }
      user = User.mapToObject(jsonDecode(json));
      isAuth = true;
    });
  }

  // Future<void> tryAutoLogin() {
  //   return AuthData.loadFromStore().then((authDataFromStore) {
  //     if (authDataFromStore == null) {
  //       return;
  //     }
  //     authData = authDataFromStore;
  //   });
  // }

  Future<void> signin(String fullname, String accessToken) async {
    user = User(fullname: fullname, accessToken: accessToken);
    isAuth = true;
    await KeyJsonStorage.set(_authKey, jsonEncode(User.toMap(user!)));
    notifyListeners();
  }

  Future<void> logoff() async {
    user = null;
    isAuth = false;
    await KeyJsonStorage.clear(_authKey);
    notifyListeners();
  }
}
