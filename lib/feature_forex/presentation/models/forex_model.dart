import 'package:intl/intl.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';

class ForexUIModel {
  ForexEntity forexEntity;
  String _publishedDateMomentAgo;
  ForexUIModel(this.forexEntity) {
    this._publishedDateMomentAgo = relativeTimeString(forexEntity.publishedAt);
  }
  like() {
    if (forexEntity.isLiked) return;
    forexEntity = forexEntity.copyWith(
        isLiked: true, likeCount: forexEntity.likeCount + 1);
  }

  unlike() {
    if (!forexEntity.isLiked) return;
    forexEntity = forexEntity.copyWith(
        isLiked: false, likeCount: forexEntity.likeCount - 1);
  }

  String get formattedLikeCount =>
      NumberFormat.compact().format(forexEntity.likeCount);
  String get formattedCommentCount =>
      NumberFormat.compact().format(forexEntity.commentCount);
  String get formattedShareCount =>
      NumberFormat.compact().format(forexEntity.shareCount);
  String get formattedViewCount =>
      NumberFormat.compact().format(forexEntity.viewCount);
  String get publishedDateMomentAgo => _publishedDateMomentAgo;
  String get formatttedDate =>
      DateFormat('dd MMMM, yyyy').format(forexEntity.publishedAt);
}
