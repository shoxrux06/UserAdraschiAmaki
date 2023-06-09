import 'package:afisha_market/core/data/repository/category_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductCategoryResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/UserCategoryResponse.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';

import '../../source/remote/response/CategoryResponse.dart';
import '../../source/remote/response/filtered_product_category_response.dart';

class CategoryRepositoryImpl extends CategoryRepository{
  // @override
  // Future<ApiResult<ProductCategoryResponse>> getProductCategoryList()async {
  //   try {
  //     final client = inject<HttpService>().client(requireAuth: true);
  //     final response = await client.get(
  //       '/categories',
  //     );
  //     return ApiResult.success(data: ProductCategoryResponse.fromJson(response.data));
  //   } catch (e) {
  //     print('==> categories failure: $e');
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }
  //
  // @override
  // Future<ApiResult<UserCategoryResponse>> getUserCategoryList() async{
  //   try {
  //     final client = inject<HttpService>().client(requireAuth: false);
  //     final response = await client.get(
  //       '/users-categories',
  //     );
  //     return ApiResult.success(data: UserCategoryResponse.fromJson(response.data));
  //   } catch (e) {
  //     print('==> users-categories failure: $e');
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }
  //
  @override
  Future<ApiResult<CategoryResponse>> getSelectedProductCategoryList() async{
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/product-categories',
      );
      return ApiResult.success(data: CategoryResponse.fromJson(response.data));
    } catch (e) {
      print('==> users-categories failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}