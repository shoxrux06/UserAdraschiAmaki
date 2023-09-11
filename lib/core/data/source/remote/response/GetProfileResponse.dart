// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());

class GetProfileResponse {
  bool status;
  UserClass user;
  List<ProductProfile> products;

  GetProfileResponse({
    required this.status,
    required this.user,
    required this.products,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) => GetProfileResponse(
    status: json["status"],
    user: UserClass.fromJson(json["user"]),
    products: List<ProductProfile>.from(json["products"].map((x) => ProductProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductProfile {
  int id;
  Category category;
  String price;
  String? discount;
  String? eni;
  String? boyi;
  String gramm;
  String color;
  IshlabChiqarishTuri ishlabChiqarishTuri;
  String mahsulotTola;
  String brand;
  UsernameEnum user;
  int likes;
  int views;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> photos;
  UserClass owner;

  ProductProfile({
    required this.id,
    required this.category,
    required this.price,
    required this.discount,
    required this.eni,
    required this.boyi,
    required this.gramm,
    required this.color,
    required this.ishlabChiqarishTuri,
    required this.mahsulotTola,
    required this.brand,
    required this.user,
    required this.likes,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
    required this.photos,
    required this.owner,
  });

  factory ProductProfile.fromJson(Map<String, dynamic> json) => ProductProfile(
    id: json["id"],
    category: categoryValues.map[json["category"]]!,
    price: json["price"],
    discount: json["discount"],
    eni: json["eni"],
    boyi: json["boyi"],
    gramm: json["gramm"],
    color: json["color"],
    ishlabChiqarishTuri: ishlabChiqarishTuriValues.map[json["ishlab_chiqarish_turi"]]!,
    mahsulotTola: json["mahsulot_tola"],
    brand: json["brand"],
    user: usernameEnumValues.map[json["user"]]!,
    likes: json["likes"],
    views: json["views"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    photos: List<String>.from(json["photos"].map((x) => x)),
    owner: UserClass.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": categoryValues.reverse[category],
    "price": price,
    "discount": discount,
    "eni": eni,
    "boyi": boyi,
    "gramm": gramm,
    "color": color,
    "ishlab_chiqarish_turi": ishlabChiqarishTuriValues.reverse[ishlabChiqarishTuri],
    "mahsulot_tola": mahsulotTola,
    "brand": brand,
    "user": usernameEnumValues.reverse[user],
    "likes": likes,
    "views": views,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "owner": owner.toJson(),
  };
}

enum Category {
  ADRAS,
  ATLAS,
  CHO_PON
}

final categoryValues = EnumValues({
  "Adras": Category.ADRAS,
  "Atlas": Category.ATLAS,
  "Cho'pon": Category.CHO_PON
});

enum IshlabChiqarishTuri {
  AVTOMAT,
  QO_L_MEHNATI,
  YARIM_TAYYOR
}

final ishlabChiqarishTuriValues = EnumValues({
  "Avtomat": IshlabChiqarishTuri.AVTOMAT,
  "Qo'l Mehnati": IshlabChiqarishTuri.QO_L_MEHNATI,
  "Yarim Tayyor": IshlabChiqarishTuri.YARIM_TAYYOR
});

class UserClass {
  int id;
  String firstName;
  String lastName;
  String phone;
  UsernameEnum username;

  UserClass({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.username,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    username: usernameEnumValues.map[json["username"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "username": usernameEnumValues.reverse[username],
  };
}

enum UsernameEnum {
  ELYOR737373
}

final usernameEnumValues = EnumValues({
  "elyor737373": UsernameEnum.ELYOR737373
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
