import 'package:afisha_market/core/data/source/remote/request/ForgotPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/ResetPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';

import '../../data/source/remote/request/SignInRequest.dart';

abstract class AuthEvent {}

class AuthEmptyEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final SignInRequest signInRequest;

  SignInEvent(this.signInRequest);
}

class SignInEvent2 extends AuthEvent {
  SignInEvent2();
}

class SignUpEvent extends AuthEvent {
  final SignUpRequest signUpRequest;

  SignUpEvent(this.signUpRequest);
}

class ForgotPasswordEvent extends AuthEvent {
  final ForgotPasswordRequest forgotPasswordRequest;

  ForgotPasswordEvent(this.forgotPasswordRequest);
}

class NewPasswordEvent extends AuthEvent {
  final ResetPasswordRequest resetPasswordRequest;

  NewPasswordEvent(this.resetPasswordRequest);
}

class VerifyEvent extends AuthEvent {
  final VerifyRequest verifyRequest;

  VerifyEvent(this.verifyRequest);
}

class DeleteAccountEvent extends AuthEvent {
  final String token;

  DeleteAccountEvent(this.token);
}