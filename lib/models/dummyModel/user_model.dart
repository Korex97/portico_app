class UserModel {
  late String email;
  late String password;
  late String type;

  UserModel(
    this.email,
    this.password,
    this.type,
  );

  String get getType => type;

  set setType(String value) {
    type = value;
  }

  String get getPassword => password;

  set setPassword(String value) {
    password = value;
  }

  String get getEmail => email;

  set setEmail(String value) {
    email = value;
  }
}

UserModel seeker = UserModel("arogeayomidipupo@gmail.com", "Admin@123", "1");
UserModel employer = UserModel("arogeayomidipupo2@gmail.com", "Admin@123", "2");
UserModel newUser = UserModel("", "", "");
