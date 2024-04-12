import 'dart:convert';

import 'package:frontend/services/http/routes.dart';
import 'package:http/http.dart' as http;

class SignInHttpRequest {
  String email;
  String password;

  SignInHttpRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class SignInHttpResponse {
  String token;

  SignInHttpResponse({required this.token});
}

class SignInHttp {
  Future<SignInHttpResponse> handle(SignInHttpRequest data) async {
    var client = http.Client();
    try {
      String json = jsonEncode(data.toMap());
      var response = await client.post(
        Uri.parse(RoutesHttp.signIn),
        body: json,
      );

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw 'Email ou password incorretos';
      }
      if (response.statusCode >= 500) {
        throw 'Serviço indisponível no momento';
      }

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return SignInHttpResponse(token: decodedResponse["token"]);
    } finally {
      client.close();
    }
  }
}
