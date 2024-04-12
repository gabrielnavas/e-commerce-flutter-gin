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

  static String? _validateIndividualName(String value) {
    if (value.isEmpty) {
      return "Name is empty.";
    }

    int minimalCharacter = 3;
    if (value.length < 2) {
      return "Each name must have at least $minimalCharacter characters.";
    }

    if (value.length > 100) {
      return "Very big name.";
    }

    return null;
  }

  static String? validateFullname(String value) {
    String? nameValid = _validateIndividualName(value);
    if (nameValid != null) {
      return nameValid;
    }

    List<String> names = value.trim().split(" ");
    if (names.length == 1) {
      return "Name must be a surname.";
    } else {
      for (String name in names) {
        String? nameValid = _validateIndividualName(name);
        if (nameValid != null) {
          return nameValid;
        }
      }
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
