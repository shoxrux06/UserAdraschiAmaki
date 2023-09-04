import 'package:afisha_market/core/data/models/locale_product.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

abstract class CartRepository {
  Future<Cart> getCartItems();
  Future<void> removeCartItem(CartItem cartItem);
}