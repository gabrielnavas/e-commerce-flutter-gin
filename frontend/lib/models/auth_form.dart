import 'package:frontend/models/auth.dart';

class AuthForm {
  late String fullName;
  late bool fullNameValid;

  late String email;
  late bool emailValid;

  late String password;
  late bool passwordValid;

  late String passwordConfirmation;
  late bool passwordConfirmationValid;

  AuthForm({
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.passwordConfirmation = "",
  }) {
    emailValid = false;
    fullNameValid = false;
    passwordValid = false;
    passwordConfirmationValid = false;
  }

  static String? validateFullname(String value) {
    String? nameValid = User.validateFullname(value);
    if (nameValid != null) {
      return nameValid;
    }
    return null;
  }

  static String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!(regex.hasMatch(value))) {
      return "Invalid e-mail.";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is empty.";
    }
    if (value.length < 6) {
      return "Password must be longer than 6 characters.";
    }
    if (value.length > 50) {
      return "Password too long.";
    }
    return null;
  }

  static String? validatePasswords(
    String password,
    String passwordConfirmation,
  ) {
    if (password != passwordConfirmation) {
      return "Password and password confirmation are different.";
    }
    return null;
  }
}
