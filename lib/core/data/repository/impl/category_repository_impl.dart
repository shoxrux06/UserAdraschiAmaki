import 'package:afisha_market/core/data/repository/category_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductCategoryResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/UserCategoryResponse.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';

class CategoryRepositoryImpl extends CategoryRepository{
  @override
  Future<ApiResult<ProductCategoryResponse>> getProductCategoryList()async {
    try {
      await Future.delayed(Duration(seconds: 10));
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/categories',
      );
      return ApiResult.success(data: ProductCategoryResponse.fromJson(response.data));
    } catch (e) {
      print('==> categories failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UserCategoryResponse>> getUserCategoryList() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/users-categories',
      );
      return ApiResult.success(data: UserCategoryResponse.fromJson(response.data));
    } catch (e) {
      print('==> users-categories failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}