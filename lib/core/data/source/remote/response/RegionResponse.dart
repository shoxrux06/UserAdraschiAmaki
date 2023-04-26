class RegionResponse {
  RegionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Region> data;

  factory RegionResponse.fromJson(Map<String, dynamic> json) => RegionResponse(
    status: json["status"],
    message: json["message"],
    data: List<Region>.from(json["data"].map((x) => Region.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Region {
  Region({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"]??0,
    name: json["name"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
