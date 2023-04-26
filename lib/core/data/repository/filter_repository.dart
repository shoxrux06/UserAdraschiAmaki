import 'package:afisha_market/core/data/source/remote/response/ProductDetailResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';

abstract class FilterRepository {
  Future<ApiResult<List<ProductDetail>>> getProductByRegion(int id);
  Future<ApiResult<List<ProductDetail>>> getProductByCategory(int id);
}
