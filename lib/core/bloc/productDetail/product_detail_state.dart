part of 'product_detail_bloc.dart';

@immutable
class ProductDetailState {
  final List<ProductDetail> product;
  final Status status;

  const ProductDetailState({
    this.product = const [],
    this.status = Status.initial,
  });

  ProductDetailState copyWith({
    List<ProductDetail>? product,
    Status? status,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      status: status ?? this.status,
    );
  }
}
