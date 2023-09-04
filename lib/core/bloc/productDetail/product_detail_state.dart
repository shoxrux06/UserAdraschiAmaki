part of 'product_detail_bloc.dart';

@immutable
class ProductDetailState {
  final List<Product> product;
  final List<LocaleProduct> productModel;
  final Status status;

  const ProductDetailState({
    this.product = const [],
    this.productModel = const [],
    this.status = Status.initial,
  });

  ProductDetailState copyWith({
    List<Product>? product,
    List<LocaleProduct>? productModel,
    Status? status,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      productModel: productModel ?? this.productModel,
      status: status ?? this.status,
    );
  }
}
