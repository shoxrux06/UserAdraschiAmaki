import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';

abstract class CreateEvent {}

class CreateInitialEvent extends CreateEvent {}

class CreateSuccessEvent extends CreateEvent {
  final CreateRequest createRequest;

  CreateSuccessEvent(this.createRequest);
}

class CreateErrorEvent extends CreateEvent {}
