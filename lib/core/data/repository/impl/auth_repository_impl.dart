import 'package:afisha_market/core/data/repository/auth_repository.dart';
import 'package:afisha_market/core/data/source/remote/request/ForgotPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/ResetPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignInRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/SignInResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/VerifyResponse.dart';
import 'package:afisha_market/core/di/inject.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/app_helpers.dart';
import '../../source/remote/response/status_and_message_response.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<ApiResult<SignInResponse>> signIn(SignInRequest request) async{
    try {
      final client = inject<HttpService>().client(requireAuth: false);
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
  Future<ApiResult<VerifyResponse>> verify(BuildContext context,VerifyRequest request) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
          '/verify',
          data: request.toJson()
      );
      return ApiResult.success(data: VerifyResponse.fromJson(response.data));
    }on DioError catch(e){
      print('==> verify failure: $e');
      AppHelpers.showCheckFlash(context, e.response?.data);
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
    catch (e) {
      print('==> verify failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }


  @override
  Future<ApiResult<StatusAndMessageResponse>> signUp(BuildContext context,SignUpRequest request)async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final formData = FormData.fromMap(await request.toJson());
      final response = await client.post(
          '/register',
          data: formData
      );
      print('signup response:${response.data}');
      return ApiResult.success(data: StatusAndMessageResponse.fromJson(response.data));
    } on DioError catch (e) {
      print('==> signup failure: ${e.runtimeType}');
      AppHelpers.showCheckFlash(context, e.response?.data['message']??'No message');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }catch (e){
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<StatusAndMessageResponse>> forgotPassword(BuildContext context,ForgotPasswordRequest request) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/forgot-password',
          data: request.toJson()
      );
      return ApiResult.success(data: StatusAndMessageResponse.fromJson(response.data));
    }on DioError catch (e) {
      print('==> signup failure: ${e.runtimeType}');
      AppHelpers.showCheckFlash(context, e.response?.data['message']??'No message');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
    catch (e) {
      print('==> forgot-password failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<StatusAndMessageResponse>> newPassword(ResetPasswordRequest request)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/new-password',
          data: request.toJson()
      );
      return ApiResult.success(data: StatusAndMessageResponse.fromJson(response.data));
    } catch (e) {
      print('==> new-password failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<StatusAndMessageResponse>> deleteAccount(String token)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      client.options.headers.addAll({'Authorization': 'Bearer $token'});
      final response = await client.post(
          '/delete-account',
      );
      return ApiResult.success(data: StatusAndMessageResponse.fromJson(response.data));
    } catch (e) {
      print('==> delete-account failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<StatusAndMessageResponse>> reSendOTP(BuildContext context, String phone)async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
          '/resend-code',
          data: {'phone': phone}
      );
      return ApiResult.success(data: StatusAndMessageResponse.fromJson(response.data));
    } catch (e) {
      print('==> resend-code failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }


}