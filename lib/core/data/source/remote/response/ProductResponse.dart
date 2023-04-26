class ProductResponse {
  ProductResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

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
  Data({
    required this.item,
    required this.links,
    required this.meta,
  });

  List<Product> item;
  Links links;
  Meta meta;

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
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.body,
    required this.category,
    required this.color,
    this.compatibility,
    required this.user,
    required this.views,
    this.longitude,
    this.latitude,
    required this.createdAt,
    required this.updatedAt,
    required this.photos,
    required this.owner,
  });

  int id;
  String title;
  int price;
  String body;
  String category;
  String color;
  String? compatibility;
  String user;
  int views;
  dynamic longitude;
  dynamic latitude;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> photos;
  Owner owner;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        body: json["body"],
        category: json["category"],
        color: json["color"],
        compatibility: json["compatibility"] ?? "",
        user: json["user"],
        views: json["views"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        photos: List<String>.from(json["photos"].map((x) => x)),
        owner: Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "body": body,
        "category": category,
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

class Links {
  Links({
    this.prevPageUrl,
    this.nextPageUrl,
  });

  dynamic prevPageUrl;
  dynamic nextPageUrl;

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
  Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  int total;
  int perPage;
  int currentPage;
  int lastPage;

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

class Owner {
  Owner({
    required this.id,
    required this.fullname,
    required this.username,
    required this.phone,
    required this.address,
    required this.phoneVerifiedAt,
    required this.role,
    required this.adminUserCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.views,
    required this.productNumber,
    required this.blocked,
  });

  int id;
  String fullname;
  String username;
  String phone;
  String address;
  DateTime phoneVerifiedAt;
  int role;
  String adminUserCategoryId;
  DateTime createdAt;
  DateTime updatedAt;
  String? avatar;
  int views;
  int productNumber;
  int blocked;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
        phone: json["phone"],
        address: json["address"],
        phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
        role: json["role"],
        adminUserCategoryId: json["admin_user_category_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        avatar: json["avatar"] ?? "",
        views: json["views"],
        productNumber: json["product_number"],
        blocked: json["blocked"],
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
        "avatar": avatar,
        "views": views,
        "product_number": productNumber,
        "blocked": blocked,
      };
}
