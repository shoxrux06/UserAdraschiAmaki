import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final BuildContext context;
  final String fullname;
  final String password;
  final File? avatar;

  UpdateProfileEvent(this.context, this.fullname, this.password, this.avatar);
}
