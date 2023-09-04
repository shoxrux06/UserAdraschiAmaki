import 'package:afisha_market/core/bloc/home/home_bloc.dart';
import 'package:afisha_market/core/data/models/locale_product.dart';
import 'package:afisha_market/core/data/repository/product_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../db/db_provider.dart';
import '../../di/dependency_manager.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository _productRepository;

  ProductDetailBloc(this._productRepository)
      : super(const ProductDetailState()) {
    on<AddToCartEvent>((event, emit) async {
      try {
        final newProduct = LocaleProduct(
          productId: event.productModel.productId,
          image: event.productModel.image,
          quantity: event.productModel.quantity,
          productName: event.productModel.productName,
          totalSum: event.productModel.totalSum,
          price: event.productModel.price,
        );
        await localProductSource.saveProduct(newProduct: newProduct);
      } catch (e) {
        print(e);
      }
    });

    on<ProductDetailDataEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final response = await _productRepository.getProduct(event.id);
        response.when(
          success: (data) {
            var list = <Product>[];
            list.add(data);
            emit(state.copyWith(status: Status.success, product: list));
          },
          failure: (failure) {},
        );
      } catch (e) {}
    });
  }
}
