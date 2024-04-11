import 'dart:convert';

import 'package:frontend/services/http/routes.dart';
import 'package:http/http.dart' as http;

class SignUpHttpRequest {
  String fullname;
  String email;
  String password;
  String passwordConfirmation;

  SignUpHttpRequest({
    required this.fullname,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      "full_name": fullname,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}

class SignUpHttpResponse {
  String token;

  SignUpHttpResponse({required this.token});
}

class SignUpHttp {
  Future<SignUpHttpResponse> handle(SignUpHttpRequest data) async {
    var client = http.Client();
    try {
      String json = jsonEncode(data.toMap());
      var response = await client.post(
        Uri.parse(RoutesHttp.signup),
        body: json,
      );

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw 'E-Email já em uso';
      }
      if (response.statusCode >= 500) {
        throw 'Serviço indisponível no momento';
      }

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return SignUpHttpResponse(token: decodedResponse["token"]);
    } finally {
      client.close();
    }
  }
}
