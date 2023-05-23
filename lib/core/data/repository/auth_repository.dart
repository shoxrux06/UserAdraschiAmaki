import 'package:afisha_market/core/data/source/remote/request/ForgotPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/ResetPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignInRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/SignInResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/VerifyResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';
import 'package:flutter/cupertino.dart';

import '../source/remote/response/status_and_message_response.dart';

abstract class AuthRepository {
  Future<ApiResult<SignInResponse>> signIn(SignInRequest request);
  Future<ApiResult<VerifyResponse>> verify(BuildContext context,VerifyRequest request);
  Future<ApiResult<StatusAndMessageResponse>> signUp(BuildContext context,SignUpRequest request);
  Future<ApiResult<StatusAndMessageResponse>> deleteAccount(String token);
  Future<ApiResult<StatusAndMessageResponse>> forgotPassword(BuildContext context,ForgotPasswordRequest request);
  Future<ApiResult<StatusAndMessageResponse>> reSendOTP(BuildContext context,String phone);
  Future<ApiResult<StatusAndMessageResponse>> newPassword(ResetPasswordRequest request);
}