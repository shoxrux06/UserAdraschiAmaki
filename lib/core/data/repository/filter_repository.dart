import 'package:afisha_market/core/handlers/api_result.dart';
import '../source/remote/response/GetProfileResponse.dart';
import '../source/remote/response/ProductResponse.dart';

abstract class FilterRepository {
  Future<ApiResult<List<Product>>> getProductByRegion(int id);
  Future<ApiResult<List<Product>>> getProductByDistrict(int id);
  Future<ApiResult<List<ProductDetail>>> getProductByCategory(int id);
}
