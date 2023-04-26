class UserCategoryResponse{
  List<UserCategory> list;

  UserCategoryResponse({required this.list});

  factory UserCategoryResponse.fromJson(Map<String, dynamic> json) => UserCategoryResponse(
    list: List<UserCategory>.from(json["data"].map((x) => UserCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<UserCategory>.from(list.map((x) => x.toJson())),
  };

}

class UserCategory {
  UserCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
    id: json["id"],
    name: json["name"],
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
