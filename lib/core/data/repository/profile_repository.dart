import 'package:afisha_market/core/data/source/remote/response/GetProfileResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductOwnerResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';

abstract class ProfileRepository{
  Future<ApiResult<GetProfileResponse>> getProfile();
  Future<ApiResult<ProductOwnerResponse>> openOwnerProfile(int id);
}