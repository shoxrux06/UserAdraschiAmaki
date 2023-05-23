import 'dart:io';

import 'package:afisha_market/core/data/source/remote/request/ForgotPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/ResetPasswordRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';
import 'package:flutter/material.dart';

import '../../data/source/remote/request/SignInRequest.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final SignInRequest signInRequest;

  SignInEvent(this.signInRequest);
}

class SignUpEvent extends AuthEvent {
  final SignUpRequest signUpRequest;

  final BuildContext context;
  SignUpEvent(this.signUpRequest, this.context);
}

class ForgotPasswordEvent extends AuthEvent {
  final BuildContext context;
  final ForgotPasswordRequest forgotPasswordRequest;

  ForgotPasswordEvent(this.context,this.forgotPasswordRequest);
}

class NewPasswordEvent extends AuthEvent {
  final ResetPasswordRequest resetPasswordRequest;

  NewPasswordEvent(this.resetPasswordRequest);
}

class VerifyEvent extends AuthEvent {
  final BuildContext context;
  final VerifyRequest verifyRequest;

  VerifyEvent(this.context,this.verifyRequest);
}

class DeleteAccountEvent extends AuthEvent {
  final String token;

  DeleteAccountEvent(this.token);
}

class AuthImagePickedEvent extends AuthEvent {
  final File avatar;

  AuthImagePickedEvent(this.avatar);
}
class ResendCodeEvent extends AuthEvent{
  final BuildContext context;

  final String phone;
  ResendCodeEvent(this.context,this.phone);
}