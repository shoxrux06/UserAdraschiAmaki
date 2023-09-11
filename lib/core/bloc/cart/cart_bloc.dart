import 'dart:async';
import 'package:afisha_market/core/bloc/cart/cart_event.dart';
import 'package:afisha_market/core/bloc/cart/cart_state.dart';
import 'package:afisha_market/db/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on(cartInitEvent);
    on(cartDeleteEvent);
    on(clearCartTable);
    on(cartIncreaseDecreaseEvent);
  }

  FutureOr<void> cartInitEvent(
    CartInitEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final productResponse = await DbManager().getDataList();
      final list = await DbManager().getDataList();
      int totalSum = 0;
      for (var localProduct in list) {
        totalSum = totalSum + localProduct.quantity * (int.parse(localProduct.price));
      }
      emit(state.copyWith(
        productList: productResponse,
        totalSum: totalSum,
      ));
    } catch (e) {
      emit(state.copyWith());
    }
  }

  FutureOr<void> cartDeleteEvent(
    CartProductDeleteEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await DbManager().deleteData(event.localeProduct);
      final productResponse = await DbManager().getDataList();
      int totalSum = 0;
      for (var localProduct in productResponse) {
        totalSum = totalSum + localProduct.quantity * (int.parse(localProduct.price));
      }
      emit(state.copyWith(productList: productResponse, totalSum: totalSum));
    } catch (e) {
      emit(state.copyWith());
    }
  }

  FutureOr<void> clearCartTable(
      CartClearEvent event,
      Emitter<CartState> emit,
      ) async {
    try {
      await DbManager().clearCartTable();
      final productResponse = await DbManager().getDataList();
      emit(state.copyWith(productList: productResponse));
    } catch (e) {
      emit(state.copyWith());
    }
  }

  FutureOr<void> cartIncreaseDecreaseEvent(
    CartProductIncreaseDecreaseEvent event,
    Emitter<CartState> emit,
  ) async {
    final product = state.productList.firstWhere((element) => element.productId  ==event.productId);
    DbManager().updateData(product);
    int totalSum = 0;
    if (event.isIcnDec) {
      product.incQuantity();
      final list = await DbManager().getDataList();
      for (var localProduct in list) {
        totalSum = totalSum + localProduct.quantity * (int.parse(localProduct.price));
        final newState = state.copyWith(totalSum: totalSum);
        emit(newState);
      }
    } else {
      product.decQuantity();
      final list = await DbManager().getDataList();
      for (var localProduct in list) {
        totalSum = totalSum - localProduct.quantity * (int.parse(localProduct.price));
        final newState = state.copyWith(totalSum: totalSum.abs());
        emit(newState);
      }
    }
  }
}
