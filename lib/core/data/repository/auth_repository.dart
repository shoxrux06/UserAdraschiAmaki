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
import 'package:afisha_market/core/handlers/api_result.dart';

abstract class AuthRepository{
  Future<ApiResult<SignInResponse>> signIn(SignInRequest request);
  Future<ApiResult<SignUpResponse>> signUp(SignUpRequest request);
  Future<ApiResult<DeleteAccountResponse>> deleteAccount(String token);
  Future<ApiResult<VerifyResponse>> verify(VerifyRequest request);
  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(ForgotPasswordRequest request);
  Future<ApiResult<ResetPasswordResponse>> newPassword(ResetPasswordRequest request);
}