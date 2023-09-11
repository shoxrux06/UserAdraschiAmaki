import 'dart:io';

import 'package:dio/dio.dart';

class SignUpRequest {
  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    // required this.avatar,
    required this.password,
    required this.passwordConfirmation,
  });

  String firstName;
  String lastName;
  String username;
  String phone;
  String password;
  String passwordConfirmation;
  // File avatar;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        phone: json["phone"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        // avatar: json["avatar"],
      );

  Map<String, dynamic> toJson()  {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "phone": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
      // "avatar": await MultipartFile.fromFile(avatar.path, filename: 'upload.png'),
    };
  }
}
