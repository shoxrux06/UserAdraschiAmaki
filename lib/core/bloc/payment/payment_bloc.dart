import 'dart:async';

import 'package:afisha_market/core/bloc/payment/payment_state.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../data/repository/payment_repository.dart';

part 'payment_event.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc(this.paymentRepository) : super(const PaymentState()) {
    on<CreateTransactionEvent>((event, emit) async {
      emit(state.copyWith(isPaying: true));
      try {
        final createTransactionResponse = await paymentRepository.createTransaction(event.context, event.amount, event.secretCode);
        createTransactionResponse.when(
          success: (data) {
            emit(state.copyWith(isPayed: true, message: data.message, isPaying:false));
          },
          failure: (failure) {
            emit(state.copyWith(isErrorOccurred: true,isPaying:false,isPayed: false));
          },
        );
      } on DioError {
        emit(state.copyWith(isErrorOccurred: true, isPaying:false,isPayed: false));
      } catch (e) {
        emit(state.copyWith(isErrorOccurred: true, isPaying:false, isPayed: false));
      }
    });
  }
}
