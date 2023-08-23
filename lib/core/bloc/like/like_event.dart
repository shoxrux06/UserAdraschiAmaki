import 'package:flutter/cupertino.dart';

abstract class LikeEvent {}

class LikedProductEvent extends LikeEvent {
  final BuildContext context;
  final int id;

  LikedProductEvent({
    required this.context,
    required this.id,
  });
}

class UnLikedProductEvent extends LikeEvent {
  final BuildContext context;
  final int id;

  UnLikedProductEvent({
    required this.context,
    required this.id,
  });
}
