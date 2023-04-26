import 'package:afisha_market/core/data/repository/profile_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/GetProfileResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductOwnerResponse.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';

class ProfileRepositoryImpl extends ProfileRepository{
  @override
  Future<ApiResult<GetProfileResponse>> getProfile() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/profile',
      );
      return ApiResult.success(data: GetProfileResponse.fromJson(response.data));
    } catch (e) {
      print('==> profile failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ProductOwnerResponse>> openOwnerProfile(int id)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/profile/$id',
      );
      return ApiResult.success(data: ProductOwnerResponse.fromJson(response.data));
    } catch (e) {
      print('==> profile id failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}