import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState{
  const factory PaymentState({
    @Default(false) bool isPaying,
    @Default(false) bool isPayed,
    @Default(false) bool isErrorOccurred,
    @Default('') String message,
}) = _Intial;

}

