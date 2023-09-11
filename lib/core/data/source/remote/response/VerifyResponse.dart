// To parse this JSON data, do
//
//     final verifyResponse = verifyResponseFromJson(jsonString);

import 'dart:convert';

VerifyResponse verifyResponseFromJson(String str) => VerifyResponse.fromJson(json.decode(str));

String verifyResponseToJson(VerifyResponse data) => json.encode(data.toJson());

class VerifyResponse {
  bool status;
  String message;
  String token;
  User user;

  VerifyResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  String username;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "username": username,
  };
}
