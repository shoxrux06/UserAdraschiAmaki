// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  bool status;
  String message;
  Data data;

  ProductResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Product> item;
  Links links;
  Meta meta;

  Data({
    required this.item,
    required this.links,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    item: List<Product>.from(json["item"].map((x) => Product.fromJson(x))),
    links: Links.fromJson(json["_links"]),
    meta: Meta.fromJson(json["_meta"]),
  );

  Map<String, dynamic> toJson() => {
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
    "_links": links.toJson(),
    "_meta": meta.toJson(),
  };
}

class Product {
  int id;
  String title;
  int price;
  String body;
  String category;
  dynamic region;
  String color;
  String compatibility;
  String user;
  int views;
  dynamic longitude;
  dynamic latitude;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> photos;
  Owner owner;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.body,
    required this.category,
    this.region,
    required this.color,
    required this.compatibility,
    required this.user,
    required this.views,
    this.longitude,
    this.latitude,
    required this.createdAt,
    required this.updatedAt,
    required this.photos,
    required this.owner,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"]??0,
    title: json["title"]??'',
    price: json["price"]??0,
    body: json["body"]??'',
    category: json["category"]??'',
    region: json["region"],
    color: json["color"]??'',
    compatibility: json["compatibility"]??'',
    user: json["user"]??'',
    views: json["views"]??0,
    longitude: json["longitude"],
    latitude: json["latitude"],
    createdAt:json["created_at"] != null? DateTime.parse(json["created_at"]): DateTime.now(),
    updatedAt: json["updated_at"] != null? DateTime.parse(json["updated_at"]): DateTime.now(),
    photos: List<String>.from(json["photos"].map((x) => x)),
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "body": body,
    "category": category,
    "region": region,
    "color": color,
    "compatibility": compatibility,
    "user": user,
    "views": views,
    "longitude": longitude,
    "latitude": latitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "owner": owner.toJson(),
  };
}

class Owner {
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

  Owner({
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

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"]??0,
    fullname: json["fullname"]??'',
    username: json["username"]??'',
    phone: json["phone"]??'',
    status: json["status"]??'',
    viloyat: json["viloyat"]??'',
    tuman: json["tuman"]??'',
    productNumber: json["product_number"]??0,
    phoneVerifiedAt:json["phone_verified_at"]!=null? DateTime.parse(json["phone_verified_at"]): DateTime.now(),
    role: json["role"]??0,
    adminUserCategory: json["admin_user_category"]??'',
    createdAt:json["created_at"] != null? DateTime.parse(json["created_at"]): DateTime.now(),
    updatedAt: json["updated_at"] != null? DateTime.parse(json["updated_at"]): DateTime.now(),
    avatar: json["avatar"]??'',
    views: json["views"]??0,
    blocked: json["blocked"]??'',
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

class Links {
  dynamic prevPageUrl;
  dynamic nextPageUrl;

  Links({
    this.prevPageUrl,
    this.nextPageUrl,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    prevPageUrl: json["prevPageUrl"],
    nextPageUrl: json["nextPageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "prevPageUrl": prevPageUrl,
    "nextPageUrl": nextPageUrl,
  };
}

class Meta {
  int total;
  int perPage;
  int currentPage;
  int lastPage;

  Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    perPage: json["perPage"],
    currentPage: json["currentPage"],
    lastPage: json["lastPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "perPage": perPage,
    "currentPage": currentPage,
    "lastPage": lastPage,
  };
}
