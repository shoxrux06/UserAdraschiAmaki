
class SignUpRequest {
  SignUpRequest({
    required this.fullname,
    required this.username,
    required this.phone,
    required this.address,
    required this.password,
    required this.passwordConfirmation,
  });

  String fullname;
  String username;
  String phone;
  String address;
  String password;
  String passwordConfirmation;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    fullname: json["fullname"],
    username: json["username"],
    phone: json["phone"],
    address: json["address"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "username": username,
    "phone": phone,
    "address": address,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
