
import 'dart:convert';
import 'dart:io';

CreateResponse createResponseFromJson(String str) => CreateResponse.fromJson(json.decode(str));

String createResponseToJson(CreateResponse data) => json.encode(data.toJson());


class CreateResponse {
  bool? status;
  String? message;
  Data? data;

  CreateResponse({
    this.status,
    this.message,
    this.data,
  });

  CreateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  int? id;
  String? title;
  int? price;
  String? body;
  String? category;
  String? region;
  String? color;
  String? compatibility;
  String? user;
  int? views;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;
  List<File>? photos;
  Owner? owner;

  Data({
    this.id,
    this.title,
    this.price,
    this.body,
    this.category,
    this.region,
    this.color,
    this.compatibility,
    this.user,
    this.views,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
    this.photos,
    this.owner,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    price = json['price'] as int?;
    body = json['body'] as String?;
    category = json['category'] as String?;
    region = json['region'] as String?;
    color = json['color'] as String?;
    compatibility = json['compatibility'] as String?;
    user = json['user'] as String?;
    views = json['views'] as int?;
    longitude = json['longitude'] as double?;
    latitude = json['latitude'] as double?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    photos = (json['photos'] as List?)?.map((dynamic e) => e as File).toList();
    owner = (json['owner'] as Map<String,dynamic>?) != null ? Owner.fromJson(json['owner'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['price'] = price;
    json['body'] = body;
    json['category'] = category;
    json['region'] = region;
    json['color'] = color;
    json['compatibility'] = compatibility;
    json['user'] = user;
    json['views'] = views;
    json['longitude'] = longitude;
    json['latitude'] = latitude;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['photos'] = photos;
    json['owner'] = owner?.toJson();
    return json;
  }
}

class Owner {
  int? id;
  String? fullname;
  String? username;
  String? phone;
  String? address;
  String? phoneVerifiedAt;
  int? role;
  String? adminUserCategoryId;
  String? createdAt;
  String? updatedAt;
  String? avatar;
  int? views;
  int? productNumber;
  int? blocked;

  Owner({
    this.id,
    this.fullname,
    this.username,
    this.phone,
    this.address,
    this.phoneVerifiedAt,
    this.role,
    this.adminUserCategoryId,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.views,
    this.productNumber,
    this.blocked,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    fullname = json['fullname'] as String?;
    username = json['username'] as String?;
    phone = json['phone'] as String?;
    address = json['address'] as String?;
    phoneVerifiedAt = json['phone_verified_at'] as String?;
    role = json['role'] as int?;
    adminUserCategoryId = json['admin_user_category_id'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    avatar = json['avatar'] as String?;
    views = json['views'] as int?;
    productNumber = json['product_number'] as int?;
    blocked = json['blocked'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['fullname'] = fullname;
    json['username'] = username;
    json['phone'] = phone;
    json['address'] = address;
    json['phone_verified_at'] = phoneVerifiedAt;
    json['role'] = role;
    json['admin_user_category_id'] = adminUserCategoryId;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['avatar'] = avatar;
    json['views'] = views;
    json['product_number'] = productNumber;
    json['blocked'] = blocked;
    return json;
  }
}