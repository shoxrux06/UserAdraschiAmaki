import 'package:afisha_market/core/data/repository/auth_repository.dart';
import 'package:afisha_market/core/data/source/remote/request/ForgotPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/ResetPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignInRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/ForgotPasswordResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/ResetPasswordResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/SignInResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/SignUpResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/VerifyResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/delete_account_response.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<ApiResult<SignInResponse>> signIn(SignInRequest request) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/login',
        data: request.toJson()
      );
      return ApiResult.success(data: SignInResponse.fromJson(response.data));
    } catch (e) {
      print('==> login failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SignUpResponse>> signUp(SignUpRequest request)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/register',
          data: request.toJson()
      );
      return ApiResult.success(data: SignUpResponse.fromJson(response.data));
    } catch (e) {
      print('==> signup failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VerifyResponse>> verify(VerifyRequest request) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/verify',
          data: request.toJson()
      );
      return ApiResult.success(data: VerifyResponse.fromJson(response.data));
    } catch (e) {
      print('==> verify failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
  @override
  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(ForgotPasswordRequest request) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/forgot-password',
          data: request.toJson()
      );
      return ApiResult.success(data: ForgotPasswordResponse.fromJson(response.data));
    } catch (e) {
      print('==> forgot-password failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ResetPasswordResponse>> newPassword(ResetPasswordRequest request)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/new-password',
          data: request.toJson()
      );
      return ApiResult.success(data: ResetPasswordResponse.fromJson(response.data));
    } catch (e) {
      print('==> new-password failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DeleteAccountResponse>> deleteAccount(String token)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      client.options.headers.addAll({'Authorization': 'Bearer $token'});
      final response = await client.post(
          '/delete-account',
      );
      return ApiResult.success(data: DeleteAccountResponse.fromJson(response.data));
    } catch (e) {
      print('==> delete-account failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }


}