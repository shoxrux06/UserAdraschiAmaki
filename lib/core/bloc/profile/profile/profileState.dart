import 'package:afisha_market/core/data/source/remote/response/GetProfileResponse.dart';

abstract class ProfileState {}

class ProfileEmptyState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class GetProfileState extends ProfileState {
  GetProfileResponse profileResponse;

  GetProfileState({required this.profileResponse});
}

class ProfileErrorState extends ProfileState {}
