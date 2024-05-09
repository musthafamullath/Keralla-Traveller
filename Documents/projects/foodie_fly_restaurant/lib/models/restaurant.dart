class RestaurantRegisteration {
  final String confirmPassword;
  final String description;
  final String email;
  final String name;
  final String password;
  final String pinCode;

  RestaurantRegisteration(
      {required this.confirmPassword,
      required this.description,
      required this.email,
      required this.name,
      required this.password,
      required this.pinCode});

  factory RestaurantRegisteration.fromJson(Map<String, dynamic> json) {
    return RestaurantRegisteration(
      confirmPassword: json['confirmPassword'],
      description: json['description'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      pinCode: json['pinCode'],
    );
  }
}
