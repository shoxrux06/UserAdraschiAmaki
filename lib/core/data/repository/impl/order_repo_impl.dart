import 'dart:convert';

import 'package:afisha_market/core/data/repository/order_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/order_response.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/db/db_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../di/inject.dart';
import '../../../handlers/http_service.dart';
import '../../../handlers/network_exceptions.dart';
import '../../../utils/app_helpers.dart';

class OrderRepoImpl implements OrderRepo{
  @override
  Future<ApiResult<OrdersResponse>> createOrder(BuildContext context, String paymentType) async{
    try {
      final carProductList = await DbManager().getDataList();
      var mainObj ={};
      var socialMedia = [];
      mainObj["payment_type"]  = paymentType;

      for(int j=0;j<carProductList.length; j++){
        var innerObj ={};
        innerObj["id"] = "${carProductList[j].productId}";
        innerObj["quantity"] = "${carProductList[j].quantity}";
        socialMedia.add(innerObj);
      }
      mainObj["products"] = socialMedia;

      final jsonData  = jsonEncode(mainObj);
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('/create-orders', data: jsonData);
      return ApiResult.success(data: OrdersResponse.fromJson(response.data));
    } on DioError catch (e) {
      print('==> Create transaction failure: $e');
      AppHelpers.showCheckFlash(context, e.response?.data['message']);
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    } catch (e) {
      print('==> Create transaction failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}