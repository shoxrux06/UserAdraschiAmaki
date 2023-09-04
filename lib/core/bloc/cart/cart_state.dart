import 'package:afisha_market/core/data/models/cart.dart';
import 'package:afisha_market/core/data/models/locale_product.dart';
import 'package:afisha_market/core/data/source/remote/request/cart_product.dart';

import '../../data/source/remote/response/ProductResponse.dart';

class CartState {
  List<LocaleProduct>? productList;
  LocaleProduct? product;

  CartState({
    List<LocaleProduct>? productList,
    LocaleProduct? product,
  }) : productList = productList ?? [];

  CartState copyWith({
    List<LocaleProduct>? productList,
    LocaleProduct? product,
  }) {
    return CartState(
      productList: productList ?? this.productList,
      product: product ?? this.product,
    );
  }
}
