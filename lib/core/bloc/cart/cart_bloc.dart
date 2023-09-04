import 'dart:async';
import 'package:afisha_market/core/bloc/cart/cart_event.dart';
import 'package:afisha_market/core/bloc/cart/cart_state.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on(cartInitEvent);
    on(cartDeleteEvent);
    on(cartIncreaseEvent);
  }

  FutureOr<void> cartInitEvent(
    CartInitEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final productResponse = await localProductSource.fetchProducts();
      emit(state.copyWith(productList: productResponse,));
    } catch (e) {
      emit(state.copyWith());
    }
  }

  FutureOr<void> cartDeleteEvent(
    CartProductDeleteEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await localProductSource.removeProduct(event.productId);
      final productResponse = await localProductSource.fetchProducts();
      emit(state.copyWith(productList: productResponse));
    } catch (e) {
      emit(state.copyWith());
    }
  }

  FutureOr<void> cartIncreaseEvent(CartProductIncreaseEvent event, Emitter<CartState> emit) {
    final product = state.productList?.firstWhere((element) => element.productId == event.productId);
    productBox.getAt(event.index);
    if(event.isIcnDec) {
      product?.incQuantity();
    }else{
      product?.decQuantity();
    }
    productBox.putAt(event.index, product!);
    emit(state.copyWith(productList: state.productList));
  }
}
