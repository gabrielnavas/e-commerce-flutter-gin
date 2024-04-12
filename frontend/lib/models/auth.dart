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
}
