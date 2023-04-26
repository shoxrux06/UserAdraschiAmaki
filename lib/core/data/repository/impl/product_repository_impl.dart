import 'package:afisha_market/core/data/repository/product_repository.dart';
import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductDetailResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<ApiResult<ProductDetailResponse>> getProduct(int id)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/products/$id',
      );
      return ApiResult.success(data: ProductDetailResponse.fromJson(response.data));
    } catch (e) {
      print('==> products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CreateResponse>> createProduct(CreateRequest request) async{
    try {
      final formData = FormData.fromMap({
        'title': request.title,
        'category_id': request.categoryId,
        'price': request.price,
        'body': request.body,
        'compatibility': request.compatibility,
        'color': request.color,
        'region_id': request.regionId,
        'photos[]': await Future.wait(
          request.photos!.map((photo) async {
            return await MultipartFile.fromFile(photo.path);
          }),
        )
      });
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/products',
        data: formData
      );
      return ApiResult.success(data: CreateResponse.fromJson(response.data));
    } catch (e) {
      print('==>create products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}