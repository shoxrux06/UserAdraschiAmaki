part of 'product_detail_bloc.dart';

@immutable
class ProductDetailState {
  final List<Product> product;
  LocaleProduct? productModel;
  final Status status;

  ProductDetailState({
    this.product = const [],
    this.productModel,
    this.status = Status.initial,
  });

  ProductDetailState copyWith({
    List<Product>? product,
    LocaleProduct? productModel,
    Status? status,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      productModel: productModel ?? this.productModel,
      status: status ?? this.status,
    );
  }
}
