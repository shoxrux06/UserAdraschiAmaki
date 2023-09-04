part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class ProductDetailInitEvent extends ProductDetailEvent{}

class AddToCartEvent extends ProductDetailEvent{
  final LocaleProduct productModel;

  AddToCartEvent(this.productModel);
}

class ProductDetailDataEvent extends ProductDetailEvent{
  final int id;

  ProductDetailDataEvent(this.id);

}
