// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) => SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  bool status;
  String message;
  String token;
  User user;

  SignInResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
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
  String fullname;
  String username;
  String phone;
  String status;
  String viloyat;
  String tuman;
  int productNumber;
  DateTime phoneVerifiedAt;
  int role;
  String adminUserCategory;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  int views;
  String blocked;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.phone,
    required this.status,
    required this.viloyat,
    required this.tuman,
    required this.productNumber,
    required this.phoneVerifiedAt,
    required this.role,
    required this.adminUserCategory,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.views,
    required this.blocked,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    username: json["username"],
    phone: json["phone"],
    status: json["status"],
    viloyat: json["viloyat"],
    tuman: json["tuman"],
    productNumber: json["product_number"],
    phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
    role: json["role"],
    adminUserCategory: json["admin_user_category"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    views: json["views"],
    blocked: json["blocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "username": username,
    "phone": phone,
    "status": status,
    "viloyat": viloyat,
    "tuman": tuman,
    "product_number": productNumber,
    "phone_verified_at": phoneVerifiedAt.toIso8601String(),
    "role": role,
    "admin_user_category": adminUserCategory,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "avatar": avatar,
    "views": views,
    "blocked": blocked,
  };
}
