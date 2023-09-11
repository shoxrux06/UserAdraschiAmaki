part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class CreateOrderEvent extends PaymentEvent{
  final BuildContext context;
  final String paymentType;

  CreateOrderEvent(this.context, this.paymentType);
}