import 'cart_item.dart';

class Cart {
  List<CartItem> listCartItem = [];

  Cart(this.listCartItem);

  double getTotalPrice() {
    double sum = 0;
    for (var cartItem in listCartItem) {
      int price = int.tryParse(cartItem.product?.price??'')??0;
      sum += (cartItem.quantity??1 * price);
    }



    return sum;
  }

  @override
  String toString() {
    return 'Cart{listCartItem: $listCartItem}';
  }
}