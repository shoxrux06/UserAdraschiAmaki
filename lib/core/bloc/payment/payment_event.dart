part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class CreateTransactionEvent extends PaymentEvent {
  final String amount;
  final String secretCode;
  final BuildContext context;

  CreateTransactionEvent(this.amount, this.secretCode,this.context);
}