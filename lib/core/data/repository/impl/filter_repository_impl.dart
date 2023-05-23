import 'package:afisha_market/core/data/repository/filter_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';

import '../../source/remote/response/GetProfileResponse.dart';

class FilterRepositoryImpl extends FilterRepository{
  @override
  Future<ApiResult<List<ProductDetail>>> getProductByCategory(int id) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/categories/$id',
      );
      return ApiResult.success(data: List<ProductDetail>.from(response.data["data"]["item"].map((e) => ProductDetail.fromJson(e))));
    } catch (e) {
      print('==> filter categories failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<List<Product>>> getProductByRegion(int id) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/regions/$id',
      );
      return ApiResult.success(data: List<Product>.from(response.data["data"]["item"].map((e) => Product.fromJson(e))));
    } catch (e) {
      print('==> regions failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}