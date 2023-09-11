class LocaleProduct {
  int productId;
  String image;
  int quantity;
  int totalSum;
  String price;
  String productName;

  LocaleProduct({
    required this.productId,
    required this.image,
    required this.quantity,
    required this.productName,
    required this.totalSum,
    required this.price,
  });

  LocaleProduct fromJson(json) {
    return LocaleProduct(
      productId: json['productId'],
      image: json['image'],
      quantity: json['quantity'],
      productName: json['productName'],
      totalSum: json['totalSum'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'productId': productId,
      'image': image,
      'quantity': quantity,
      'productName': productName,
      'totalSum': totalSum,
      'price': price,
    };
  }
  @override
  String toString() {
    return 'LocaleProduct{productId: $productId, image: $image, quantity: $quantity, totalSum: $totalSum, price: $price, productName: $productName}';
  }

  incQuantity() {
    quantity++;
  }

  int get totalSumCalc {
    return quantity * int.parse(price);
  }
  decQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
