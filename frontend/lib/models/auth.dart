class User {
  String fullname;
  String accessToken;

  User({
    required this.fullname,
    required this.accessToken,
  });

  static Map<String, dynamic> toMap(User user) {
    return {
      "full_name": user.fullname,
      "access_token": user.accessToken,
    };
  }

  static User mapToObject(Map<String, dynamic> data) {
    return User(
      fullname: data["full_name"],
      accessToken: data["access_token"],
    );
  }

  String? validate() {
    String? nameValid = validateFullname(fullname);
    if (nameValid != null) {
      return nameValid;
    }

    if (accessToken.isEmpty) {
      return "Missing access token.";
    }

    return null;
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
}
