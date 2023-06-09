import 'dart:convert';
import 'dart:io';

CreateRequest productResponseFromJson(String str) => CreateRequest.fromJson(json.decode(str));

String productResponseToJson(CreateRequest data) => json.encode(data.toJson());


class CreateRequest {
  String? title;
  int? price;
  String? body;
  int? categoryId;
  int? regionId;
  int? districtId;
  dynamic latitude;
  dynamic longitude;
  String? color;
  String? compatibility;
  List<File>? photos;

  CreateRequest({
    this.title,
    this.price,
    this.body,
    this.categoryId,
    this.regionId,
    this.districtId,
    this.latitude,
    this.longitude,
    this.color,
    this.compatibility,
    this.photos,
  });

  CreateRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    price = json['price'] as int?;
    body = json['body'] as String?;
    categoryId = json['category_id'] as int?;
    regionId = json['region_id'] as int?;
    latitude = json['latitude'] != null? json['latitude'] as double:null;
    longitude = json['longitude'] != null? json['longitude'] as double:null;
    districtId = json['district_id'] as int?;
    color = json['color'] as String?;
    compatibility = json['compatibility'] as String?;
    photos = (json['photos'] as List?)?.map((dynamic e) => e as File).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['price'] = price;
    json['body'] = body;
    json['category_id'] = categoryId;
    json['district_id'] = districtId;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['color'] = color;
    json['compatibility'] = compatibility;
    json['photos'] = photos;
    return json;
  }
}
