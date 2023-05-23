import 'package:afisha_market/core/data/source/remote/response/GetProfileResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/update_profile_response.dart';

abstract class ProfileState {}

class ProfileEmptyState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class GetProfileState extends ProfileState {
  GetProfileResponse profileResponse;

  GetProfileState({required this.profileResponse});
}

class UpdateProfileState extends ProfileState {
  UpdateProfileResponse updateProfileResponse;

  UpdateProfileState({required this.updateProfileResponse});
}

class ProfileErrorState extends ProfileState {}
