import 'package:afisha_market/core/data/models/locale_product.dart';
import 'package:equatable/equatable.dart';

class CartState {
  final List<LocaleProduct> productList;
  final int totalSum;
  final bool isChanged;

  const CartState({
    this.productList = const [],
    this.totalSum = 0,
    this.isChanged = false
  });

  CartState copyWith({
    List<LocaleProduct>? productList,
    int? totalSum,
    bool? isChanged,
  }) {
    return CartState(
      productList: productList ?? this.productList,
      totalSum: totalSum?? this.totalSum,
      isChanged: isChanged?? this.isChanged,
    );
  }
}
