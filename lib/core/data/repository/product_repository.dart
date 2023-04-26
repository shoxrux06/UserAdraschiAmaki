import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductDetailResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';

abstract class ProductRepository{
  Future<ApiResult<ProductDetailResponse>> getProduct(int id);
  Future<ApiResult<CreateResponse>> createProduct(CreateRequest request);
}