import 'package:afisha_market/core/data/source/remote/response/order_response.dart';

class PaymentState {
  final OrdersResponse? ordersResponse;
  final bool? isCreatingOrder;
  final bool? isCreatedOrder;

  PaymentState({this.ordersResponse, this.isCreatingOrder, this.isCreatedOrder});

  PaymentState copyWith(
      {OrdersResponse? ordersResponse, bool? isCreatingOrder, bool? isCreatedOrder}) {
    return PaymentState(
      ordersResponse: ordersResponse ?? this.ordersResponse,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      isCreatedOrder: isCreatedOrder ?? this.isCreatedOrder,
    );
  }
}
