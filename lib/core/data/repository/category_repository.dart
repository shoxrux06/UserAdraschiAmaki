import 'package:afisha_market/core/data/source/remote/response/CategoryResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductCategoryResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/UserCategoryResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/filtered_product_category_response.dart';
import 'package:afisha_market/core/handlers/api_result.dart';

abstract class CategoryRepository{
  Future<ApiResult<CategoryResponse>> getProductCategoryList();
  // Future<ApiResult<UserCategoryResponse>> getUserCategoryList();
  // Future<ApiResult<CategoryResponse>> getSelectedProductCategoryList();
}