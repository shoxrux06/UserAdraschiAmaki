part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeNextEvent extends HomeEvent {}

class HomeSearchEvent extends HomeEvent {
  final String text;

  HomeSearchEvent(this.text);
}

class HomeFilterEvent extends HomeEvent {
  final int regionId;

  HomeFilterEvent(this.regionId);
}

class HomeFilterByDistrictEvent extends HomeEvent {
  final int districtId;

  HomeFilterByDistrictEvent(this.districtId);
}

