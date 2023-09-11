import 'package:afisha_market/core/data/source/remote/response/order_response.dart';
import 'package:flutter/cupertino.dart';

import '../../handlers/api_result.dart';

abstract class OrderRepo{
  Future<ApiResult<OrdersResponse>> createOrder(BuildContext context, String paymentType);

}