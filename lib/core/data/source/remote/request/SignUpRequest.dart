import 'dart:io';

import 'package:dio/dio.dart';

class SignUpRequest {
  SignUpRequest({
    required this.fullname,
    required this.username,
    required this.phone,
    required this.viloyat,
    required this.rusViloyat,
    required this.tuman,
    required this.rusTuman,
    required this.adminUserCategoryId,
    required this.avatar,
    required this.password,
    required this.passwordConfirmation,
  });

  String fullname;
  String username;
  String phone;
  String viloyat;
  String rusViloyat;
  String tuman;
  String rusTuman;
  String adminUserCategoryId;
  File avatar;
  String password;
  String passwordConfirmation;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      SignUpRequest(
        fullname: json["fullname"],
        username: json["username"],
        phone: json["phone"],
        viloyat: json["viloyat"],
        rusViloyat: json["rus_viloyat"],
        tuman: json["tuman"],
        rusTuman: json["rus_tuman"],
        adminUserCategoryId: json["admin_user_category_id"],
        avatar: json["avatar"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Future<Map<String, dynamic>> toJson() async{
    return {
    "fullname": fullname,
    "username": username,
    "phone": phone,
    "viloyat": viloyat,
    "rus_viloyat": rusViloyat,
    "tuman": tuman,
    "rus_tuman": rusTuman,
    "admin_user_category_id": adminUserCategoryId,
    "avatar": await MultipartFile.fromFile(avatar.path, filename: 'upload.png'),
    "password": password,
    "password_confirmation": passwordConfirmation
  };
  }
}
