import 'package:afisha_market/core/data/repository/product_repository.dart';
import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/status_and_message_response.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProductRepositoryImpl extends ProductRepository {

  @override
  Future<ApiResult<Product>> getProduct(int id) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/products/$id',
      );
      return ApiResult.success(data: Product.fromJson(response.data['data']));
    } catch (e) {
      print('==> products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CreateResponse>> createProduct(
      BuildContext context, CreateRequest request) async {
    try {
      final formData = FormData.fromMap({
        'title': request.title,
        'category_id': request.categoryId,
        'price': request.price,
        'body': request.body,
        'compatibility': request.compatibility,
        'color': request.color,
        'region_id': request.regionId,
        'district_id': request.districtId,
        'photos[]': await Future.wait(
          request.photos!.map((photo) async {
            return await MultipartFile.fromFile(photo.path);
          }),
        )
      });
      final formData2 = FormData.fromMap({
        'title': request.title,
        'category_id': request.categoryId,
        'price': request.price,
        'body': request.body,
        'compatibility': request.compatibility,
        'color': request.color,
        'region_id': request.regionId,
        'district_id': request.districtId,
        'latitude': request.latitude,
        'longitude': request.longitude,
        'photos[]': await Future.wait(
          request.photos!.map((photo) async {
            return await MultipartFile.fromFile(photo.path);
          }),
        )
      });
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('/products',
          data: (request.latitude == null || request.longitude == null)
              ? formData
              : formData2);
      return ApiResult.success(data: CreateResponse.fromJson(response.data));
    } on DioError catch (e) {
      print(e.response);
      AppHelpers.showCheckFlash(
          context, e.response?.data['message'] ?? 'No message');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    } catch (e) {
      print('==>create products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<StatusAndMessageResponse>> deleteProduct(
      BuildContext context, int id) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete(
        '/products/$id',
      );
      return ApiResult.success(
          data: StatusAndMessageResponse.fromJson(response.data));
    } on DioError catch (e) {
      print(e.response);
      AppHelpers.showCheckFlash(
          context, e.response?.data['message'] ?? 'No message');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    } catch (e) {
      print('==>update products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CreateResponse>> updateProduct(
      BuildContext context, CreateRequest request, int id) async {
    try {
      final formData = FormData.fromMap({
        'title': request.title,
        'category_id': request.categoryId,
        'price': request.price,
        'body': request.body,
        'compatibility': request.compatibility,
        'color': request.color,
        'region_id': request.regionId,
        'district_id': request.districtId,
        'photos[]': await Future.wait(
          request.photos!.map((photo) async {
            return await MultipartFile.fromFile(photo.path);
          }),
        )
      });
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('/products/$id', data: formData);
      return ApiResult.success(data: CreateResponse.fromJson(response.data));
    } on DioError catch (e) {
      print(e.response);
      AppHelpers.showCheckFlash(
          context, e.response?.data['message'] ?? 'No message');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    } catch (e) {
      print('==>update products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }


}
