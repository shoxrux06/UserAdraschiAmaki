import 'dart:async';

import 'package:afisha_market/core/bloc/payment/payment_state.dart';
import 'package:afisha_market/core/data/repository/order_repository.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../data/repository/payment_repository.dart';

part 'payment_event.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final OrderRepo orderRepo;

  PaymentBloc(this.orderRepo) : super(PaymentState()) {
    on<CreateOrderEvent>((event, emit) async {
      emit(state.copyWith(isCreatingOrder: true));
      try {
        final createTransactionResponse = await orderRepo.createOrder(event.context, event.paymentType);
        createTransactionResponse.when(
          success: (data) {
            emit(state.copyWith(ordersResponse: data,isCreatingOrder: false, isCreatedOrder: true));
          },
          failure: (failure) {
            emit(state.copyWith(isCreatingOrder: false));
          },
        );
      } on DioError {
        emit(state.copyWith(isCreatingOrder: false));
      } catch (e) {
        emit(state.copyWith(isCreatingOrder: false));
      }
    });
  }
}
