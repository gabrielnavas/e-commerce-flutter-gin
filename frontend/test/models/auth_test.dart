import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/auth.dart';

void main() {
  test('User of the auth should be valid', () {
    final user = User(accessToken: "any_token", fullname: "any name");
    final isValid = user.validate();
    expect(isValid, null);
  });

  test('User of the auth should be invalid, because access token is empty', () {
    final user = User(accessToken: "", fullname: "any name!");
    final isValid = user.validate();
    expect(isValid, "Missing access token.");
  });

  test(
      'User of the auth should be invalid, because full name does not have last name',
      () {
    final user = User(accessToken: "", fullname: "any_name");
    final isValid = user.validate();
    expect(isValid, 'Name must be a surname.');
  });

  test('User of the auth should be invalid, because full name is empty', () {
    final user = User(accessToken: "", fullname: "");
    final isValid = user.validate();
    expect(isValid, 'Name is empty.');
  });
}
