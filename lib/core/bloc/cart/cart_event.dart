import 'package:afisha_market/core/data/models/locale_product.dart';
import 'package:afisha_market/core/data/source/remote/request/cart_product.dart';

abstract class CartEvent{}

class CartInitEvent extends CartEvent{}
class CartClearEvent extends CartEvent{}
class CartProductDeleteEvent extends CartEvent{
  final LocaleProduct localeProduct;

  CartProductDeleteEvent(this.localeProduct);
}
class CartProductIncreaseDecreaseEvent extends CartEvent{
  final int productId;
  final bool isIcnDec;
  final int index;

  CartProductIncreaseDecreaseEvent({required this.productId, required this.isIcnDec, required this.index});
}
class CartProductDecreaseEvent extends CartEvent  {}