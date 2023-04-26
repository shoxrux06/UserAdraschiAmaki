import 'package:afisha_market/core/bloc/profile/profile/profileEvent.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileState.dart';
import 'package:afisha_market/core/data/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileEmptyState()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profileResponse = await _profileRepository.getProfile();
        profileResponse.when(
          success: (data) {
            emit(GetProfileState(profileResponse: data));
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(ProfileErrorState());
      }
    });
  }
}
