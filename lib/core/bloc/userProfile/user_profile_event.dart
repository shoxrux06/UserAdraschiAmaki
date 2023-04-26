part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileEvent {}

class UserProfileInitEvent extends UserProfileEvent{}

class UserProfileDataEvent extends UserProfileEvent{
  final int userId;

  UserProfileDataEvent(this.userId);

}