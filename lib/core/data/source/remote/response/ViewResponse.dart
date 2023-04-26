class ViewResponse {
  ViewResponse({
    required this.views,
  });

  int views;

  factory ViewResponse.fromJson(Map<String, dynamic> json) => ViewResponse(
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "views": views,
  };
}
