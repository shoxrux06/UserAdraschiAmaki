import 'package:afisha_market/core/data/repository/profile_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductOwnerResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../home/home_bloc.dart';

part 'user_profile_event.dart';

part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final ProfileRepository _profileRepository;

  UserProfileBloc(this._profileRepository) : super(UserProfileState()) {
    on<UserProfileInitEvent>((event, emit) {});

    on<UserProfileDataEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        var openOwnerProfile =
            await _profileRepository.openOwnerProfile(event.userId);
        openOwnerProfile.when(
          success: (data) {
            final list = <ProductOwnerResponse>[];
            list.add(data);
            emit(state.copyWith(status: Status.success, list: list));
          },
          failure: (failure) {},
        );
      } catch (e) {}
    });
  }
}
