import 'package:afisha_market/core/data/models/locale_product.dart';
import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:flutter/cupertino.dart';

import '../source/remote/response/GetProfileResponse.dart';
import '../source/remote/response/status_and_message_response.dart';

abstract class ProductRepository{
  Future<ApiResult<Product>> getProduct(int id);
  Future<ApiResult<StatusAndMessageResponse>> deleteProduct(BuildContext context,int id);
  Future<ApiResult<CreateResponse>> updateProduct(BuildContext context,CreateRequest request,int id);
  Future<ApiResult<CreateResponse>> createProduct(BuildContext context,CreateRequest request);
}