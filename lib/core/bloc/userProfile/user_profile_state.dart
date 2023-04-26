part of 'user_profile_bloc.dart';

@immutable
class UserProfileState {
  final Status status;
  final List<ProductOwnerResponse> list;

  UserProfileState({this.list = const [], this.status = Status.initial});

  UserProfileState copyWith({Status? status, List<ProductOwnerResponse>? list}) {
    return UserProfileState(status: status ?? this.status, list: list ?? this.list);
  }
}
