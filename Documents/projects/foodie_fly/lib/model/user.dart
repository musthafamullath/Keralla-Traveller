class User {
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String password;
  final String rePassword;

  User({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.password,
    required this.rePassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fName: json["firstName"],
      lName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      rePassword: json["confirmPassword"],
    );
  }
}
