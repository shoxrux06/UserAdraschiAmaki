import 'package:hive/hive.dart';

part 'locale_product.g.dart';

@HiveType(typeId: 0)
class LocaleProduct {
  LocaleProduct({
    required this.productId,
    required this.image,
    required this.quantity,
    required this.productName,
    required this.totalSum,
    required this.price,
  });

  @HiveField(0)
  int productId;

  @HiveField(1)
  String image;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  int totalSum;

  @HiveField(4)
  String price;

  @HiveField(5)
  String productName;

  @override
  String toString() {
    return 'LocaleProduct{productId: $productId, image: $image, quantity: $quantity, totalSum: $totalSum, price: $price, productName: $productName}';
  }

  incQuantity(){
    quantity++;
  }

  decQuantity(){
    if(quantity> 1){
      quantity--;
    }

  }
}
