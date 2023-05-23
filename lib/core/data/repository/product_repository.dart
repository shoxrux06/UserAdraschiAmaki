import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:flutter/cupertino.dart';

import '../source/remote/response/GetProfileResponse.dart';
import '../source/remote/response/status_and_message_response.dart';

abstract class ProductRepository{
  Future<ApiResult<ProductDetail>> getProduct(int id);
  Future<ApiResult<StatusAndMessageResponse>> deleteProduct(BuildContext context,int id);
  Future<ApiResult<CreateResponse>> updateProduct(BuildContext context,CreateRequest request,int id);
  Future<ApiResult<CreateResponse>> createProduct(BuildContext context,CreateRequest request);
}