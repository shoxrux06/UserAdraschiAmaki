// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

OrdersResponse ordersResponseFromJson(String str) => OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  String message;
  String clickUrl;

  OrdersResponse({
    required this.message,
    required this.clickUrl,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    message: json["message"],
    clickUrl: json["click_url"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "click_url": clickUrl,
  };
}
