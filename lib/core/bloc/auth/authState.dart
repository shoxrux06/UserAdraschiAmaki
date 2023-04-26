import 'package:afisha_market/core/data/source/remote/response/ForgotPasswordResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/ResetPasswordResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/SignInResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/SignUpResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/VerifyResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/delete_account_response.dart';

abstract class AuthState {}

class AuthEmptyState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthNetworkErrorState extends AuthState {}

class AuthNotUniqueUsernameErrorState extends AuthState {}

class AuthUserLoggedErrorState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthSuccessState extends AuthState {}

class SignInState extends AuthState {
  SignInResponse signInResponse;

  SignInState({required this.signInResponse});
}

class SignUpState extends AuthState {
  SignUpResponse signUpResponse;

  SignUpState({required this.signUpResponse});
}

class ForgotPasswordState extends AuthState {
  ForgotPasswordResponse forgotPasswordResponse;

  ForgotPasswordState({required this.forgotPasswordResponse});
}

class NewPasswordState extends AuthState {
  ResetPasswordResponse resetPasswordResponse;

  NewPasswordState({required this.resetPasswordResponse});
}

class VerifyState extends AuthState {
  VerifyResponse verifyResponse;

  VerifyState({required this.verifyResponse});
}

class DeleteAccountState extends AuthState {
  DeleteAccountResponse deleteAccountResponse;

  DeleteAccountState({required this.deleteAccountResponse});
}
