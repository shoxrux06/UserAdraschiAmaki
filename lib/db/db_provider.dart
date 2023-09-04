import 'package:afisha_market/core/data/source/remote/request/cart_product.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:hive/hive.dart';

import '../core/data/models/locale_product.dart';

class LocalProductsSource {
  const LocalProductsSource(this.box);

  final Box<LocaleProduct> box;

  // ============================== Products =================================== //

  Future<void> saveProduct({
    required LocaleProduct newProduct,
  }) async {
    await box.add(newProduct);
  }

  Future<List<LocaleProduct>?> fetchProducts() async => box.values.toList();

  // void changeCount({
  //   required int index,
  //   required bool isIncrease,
  // }) async {
  //   LocaleProduct newLocaleProduct = box.values.toList()[index];
  //   if (!isIncrease) {
  //     if (box.values.toList()[index].quantity > 1) {
  //       box.values.toList()[index].totalSum -= int.tryParse(box.values.toList()[index].price) ?? 0;
  //       box.values.toList()[index].quantity--;
  //     }
  //     return;
  //   }
  //   box.values.toList()[index].totalSum += int.tryParse(box.values.toList()[index].price) ?? 0;
  //
  //   // final newOneLocaleProduct = LocaleProduct(
  //   //   productId: newLocaleProduct.productId,
  //   //   image: newLocaleProduct.image,
  //   //   quantity: box.values.toList()[index].quantity++,
  //   //   productName: newLocaleProduct.productName,
  //   //   totalSum: newLocaleProduct.totalSum,
  //   //   price: newLocaleProduct.price,
  //   // );
  //   box.putAt(index,LocaleProduct(
  //     productId: newLocaleProduct.productId,
  //     image: newLocaleProduct.image,
  //     quantity: box.values.toList()[index].quantity++,
  //     productName: newLocaleProduct.productName,
  //     totalSum: newLocaleProduct.totalSum,
  //     price: newLocaleProduct.price,
  //   ));
  //   box.values.toList()[index].quantity++;
  // }

  Future<void> removeProduct(int index) async {
    print('HERE WE GO 1');
    await box.deleteAt(index);
  }

  bool hasThisProduct(String productId) =>
      box.values.toList().any((element) => element.productId == productId);

  Future<void> removeAllProduct() async {
    await box.clear();
  }
}
