
class SignInResponse {
  SignInResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  bool status;
  String message;
  String token;
  User user;

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
  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.phone,
    this.address,
    required this.phoneVerifiedAt,
    required this.role,
    this.adminUserCategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String fullname;
  String username;
  String phone;
  dynamic address;
  DateTime phoneVerifiedAt;
  int role;
  dynamic adminUserCategoryId;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    username: json["username"],
    phone: json["phone"],
    address: json["address"],
    phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
    role: json["role"],
    adminUserCategoryId: json["admin_user_category_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "username": username,
    "phone": phone,
    "address": address,
    "phone_verified_at": phoneVerifiedAt.toIso8601String(),
    "role": role,
    "admin_user_category_id": adminUserCategoryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

