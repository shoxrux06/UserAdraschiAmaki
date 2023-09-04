
import 'package:afisha_market/core/data/models/locale_product.dart';

class CartItem {
  final int? id;
  int? quantity;
  LocaleProduct? product;

  CartItem({this.id, this.quantity, this.product});

  Map<String, dynamic> toMap() {
    return {'quantity': quantity, 'product_id': product?.productId};
  }

  @override
  String toString() {
    return 'CartItem{id: $id, quantity: $quantity, product: $product}';
  }
}