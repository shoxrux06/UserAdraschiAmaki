import 'dart:convert';
import 'dart:io';

CreateRequest productResponseFromJson(String str) => CreateRequest.fromJson(json.decode(str));

String productResponseToJson(CreateRequest data) => json.encode(data.toJson());


class CreateRequest {
  String? title;
  int? categoryId;
  int? price;
  String? body;
  String? compatibility;
  String? color;
  int? regionId;
  List<File>? photos;


  CreateRequest({
    this.title,
    this.categoryId,
    this.price,
    this.body,
    this.compatibility,
    this.color,
    this.regionId,
    this.photos,
  });

  CreateRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    categoryId = json['category_id'] as int?;
    price = json['price'] as int?;
    body = json['body'] as String?;
    compatibility = json['compatibility'] as String?;
    color = json['color'] as String?;
    regionId = json['region_id'] as int?;
    photos = (json['photos'] as List?)?.map((dynamic e) => e as File).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['category_id'] = categoryId;
    json['price'] = price;
    json['body'] = body;
    json['compatibility'] = compatibility;
    json['color'] = color;
    json['region_id'] = regionId;
    json['photos'] = photos;
    return json;
  }
}
