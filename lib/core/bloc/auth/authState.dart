import 'dart:io';

import 'package:afisha_market/core/data/source/remote/response/SignInResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/VerifyResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/status_and_message_response.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';

enum AuthStatus {
  initial,
  loading,
  error,
  success,
}

class AuthState {
  final AuthStatus status;
  final SignInResponse? signInResponse;
  final StatusAndMessageResponse? statusAndMessageResponse;
  final VerifyResponse? verifyResponse;
  final NetworkExceptions? networkExceptions;
  final bool isAuthenticating;
  final bool isVerified;
  final bool isVerifying;
  final bool isAuthenticated;
  final bool isErrorOccurred;
  final File? avatar;

  AuthState({
    this.status = AuthStatus.initial,
    this.signInResponse,
    this.statusAndMessageResponse,
    this.verifyResponse,
    this.networkExceptions,
    this.isAuthenticating = false,
    this.isVerified = false,
    this.isVerifying = false,
    this.isAuthenticated = false,
    this.isErrorOccurred = false,
    this.avatar
  });

  AuthState copyWith(
    AuthStatus? status,
    SignInResponse? signInResponse,
    StatusAndMessageResponse? statusAndMessageResponse,
    VerifyResponse? verifyResponse,
    NetworkExceptions? networkExceptions,
    bool isAuthenticating,
    bool isVerified,
    bool isVerifying,
    bool isAuthenticated,
    bool isErrorOccurred,
      File? avatar,
  ) =>
      AuthState(
        status: status ?? this.status,
        signInResponse: signInResponse ?? this.signInResponse,
        statusAndMessageResponse:
            statusAndMessageResponse ?? this.statusAndMessageResponse,
        networkExceptions: networkExceptions??this.networkExceptions,
        verifyResponse: verifyResponse,
        isAuthenticating: isAuthenticating,
        isVerified: isVerified,
        isVerifying: isVerifying,
        isAuthenticated: isAuthenticated,
        isErrorOccurred:isErrorOccurred ,
        avatar: avatar??this.avatar,
      );
}

// class AuthEmptyState extends AuthState {}
//
// class AuthLoadingState extends AuthState {}
//
// class AuthErrorState extends AuthState {}
//
// class AuthSuccessState extends AuthState {}

// class SignInState extends AuthState {
//   SignInResponse signInResponse;
//
//
//   SignInState({required this.signInResponse});
// }
//
// class SignUpState extends AuthState {
//   StatusAndMessageResponse signUpResponse;
//
//   SignUpState({required this.signUpResponse});
// }
//
// class ForgotPasswordState extends AuthState {
//   StatusAndMessageResponse forgotPasswordResponse;
//
//   ForgotPasswordState({required this.forgotPasswordResponse});
// }
//
// class NewPasswordState extends AuthState {
//   StatusAndMessageResponse resetPasswordResponse;
//
//   NewPasswordState({required this.resetPasswordResponse});
// }
//
// class VerifyState extends AuthState {
//   VerifyResponse verifyResponse;
//
//   VerifyState({required this.verifyResponse});
// }
//
// class DeleteAccountState extends AuthState {
//   StatusAndMessageResponse deleteAccountResponse;
//
//   DeleteAccountState({required this.deleteAccountResponse});
// }
