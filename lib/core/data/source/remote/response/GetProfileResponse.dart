class GetProfileResponse {
  bool? status;
  User? user;

  GetProfileResponse({
    this.status,
    this.user,
  });

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['user'] = user?.toJson();
    return json;
  }
}

class User {
  int? id;
  String? fullname;
  String? username;
  String? phone;
  String? status;
  String? address;
  String? phoneVerifiedAt;
  int? role;
  String? adminUserCategory;
  String? createdAt;
  String? updatedAt;
  dynamic avatar;
  int? views;

  User({
    this.id,
    this.fullname,
    this.username,
    this.phone,
    this.status,
    this.address,
    this.phoneVerifiedAt,
    this.role,
    this.adminUserCategory,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.views,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    fullname = json['fullname'] as String?;
    username = json['username'] as String?;
    phone = json['phone'] as String?;
    status = json['status'] as String?;
    address = json['address'] as String?;
    phoneVerifiedAt = json['phone_verified_at'] as String?;
    role = json['role'] as int?;
    adminUserCategory = json['admin_user_category'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    avatar = json['avatar'];
    views = json['views'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['fullname'] = fullname;
    json['username'] = username;
    json['phone'] = phone;
    json['status'] = status;
    json['address'] = address;
    json['phone_verified_at'] = phoneVerifiedAt;
    json['role'] = role;
    json['admin_user_category'] = adminUserCategory;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['avatar'] = avatar;
    json['views'] = views;
    return json;
  }
}