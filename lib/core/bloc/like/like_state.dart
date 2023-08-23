import 'package:afisha_market/core/data/source/remote/response/liked_response.dart';
import 'package:afisha_market/core/data/source/remote/response/unliked_response.dart';

class LikeState {
  final bool? isLiked;
  final bool? isUnLiked;
  final LikedResponse? likedResponse;
  final UnLikedResponse? unLikedResponse;

  LikeState({
    this.isLiked,
    this.isUnLiked,
    this.likedResponse,
    this.unLikedResponse,
  });

  LikeState copyWith({
    bool? isLiked,
    bool? isUnLiked,
    LikedResponse? likedResponse,
    UnLikedResponse? unLikedResponse,
  }) {
    return LikeState(
      isLiked: isLiked?? this.isLiked,
      isUnLiked: isUnLiked?? this.isUnLiked,
      likedResponse: likedResponse?? this.likedResponse,
      unLikedResponse: unLikedResponse?? this.unLikedResponse
    );
  }
}
