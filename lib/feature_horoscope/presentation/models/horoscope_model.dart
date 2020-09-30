import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';

class HoroscopeUIModel {
  HoroscopeEntity horoscopeEntity;
  HoroscopeUIModel(this.horoscopeEntity);
  like() {
    if (horoscopeEntity.isLiked) return;
    horoscopeEntity = horoscopeEntity.copyWith(
        isLiked: true, likeCount: horoscopeEntity.likeCount + 1);
  }

  unlike() {
    if (!horoscopeEntity.isLiked) return;
    horoscopeEntity = horoscopeEntity.copyWith(
        isLiked: false, likeCount: horoscopeEntity.likeCount - 1);
  }

  String get formattedLikeCount =>
      NumberFormat.compact().format(horoscopeEntity.likeCount);
  String get formattedCommentCount =>
      NumberFormat.compact().format(horoscopeEntity.commentCount);
  String get formattedShareCount =>
      NumberFormat.compact().format(horoscopeEntity.shareCount);
  String get formattedViewCount =>
      NumberFormat.compact().format(horoscopeEntity.viewCount);
  String get formattedDate =>
      DateFormat('dd MMMM, yyyy').format(horoscopeEntity.publishedAt);
}
