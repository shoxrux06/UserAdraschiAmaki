class AdvertisementItem {
  AdvertisementItem({
    required this.id,
    required this.images,
  });

  int id;
  List<dynamic> images;

  factory AdvertisementItem.fromJson(Map<String, dynamic> json) => AdvertisementItem(
    id: json["id"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
