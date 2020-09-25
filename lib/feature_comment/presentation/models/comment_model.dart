import 'package:intl/intl.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';

class CommentUIModel {
  CommentEntity comment;
  String _publishedDateMomentAgo;
  CommentUIModel(this.comment) {
    this._publishedDateMomentAgo = relativeTimeString(comment.updatedAt);
  }

  like() {
    if (comment.isLiked) return;
    comment = comment.copyWith(isLiked: true, likeCount: comment.likeCount + 1);
  }

  unlike() {
    if (!comment.isLiked) return;
    comment =
        comment.copyWith(isLiked: false, likeCount: comment.likeCount - 1);
  }

  String get formattedCommentCount =>
      NumberFormat.compact().format(comment.commentCount);
  String get formattedLikeCount =>
      NumberFormat.compact().format(comment.likeCount);
  bool isOwn(String userId) => comment.user['id'] == userId;
  String get publishedDateMomentAgo => _publishedDateMomentAgo;
}
