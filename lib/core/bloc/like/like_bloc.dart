import 'dart:async';

import 'package:afisha_market/core/bloc/like/like_event.dart';
import 'package:afisha_market/core/bloc/like/like_state.dart';
import 'package:afisha_market/core/data/repository/like_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc({required this.likeRepository}) : super(LikeState()) {
    on(_onLikedProduct);
    on(_onUnLikedProduct);
  }

  final LikeRepository likeRepository;

  FutureOr<void> _onLikedProduct(
    LikedProductEvent event,
    Emitter<LikeState> emit,
  ) async {
    final result = await likeRepository.onProductLiked(event.context, event.id);
    result.when(
      success: (likedResponse) {
        emit(state.copyWith(isUnLiked: true, likedResponse: likedResponse));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(likedResponse.message)));
      },
      failure: (failure) {
        emit(state.copyWith(isLiked: false));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(failure.toString())));
      },
    );
  }

  FutureOr<void> _onUnLikedProduct(
    UnLikedProductEvent event,
    Emitter<LikeState> emit,
  ) async{
    final result = await likeRepository.onProductUnLiked(event.context, event.id);
    result.when(
      success: (unLikedResponse) {
        emit(state.copyWith(isUnLiked: true, unLikedResponse: unLikedResponse));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(unLikedResponse.message)));
      },
      failure: (failure) {
        emit(state.copyWith(isUnLiked: false));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(failure.toString())));
      },
    );
  }
}
