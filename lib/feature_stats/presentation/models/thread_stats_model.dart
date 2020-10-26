import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';

class ThreadStatsUIModel {
  ThreadStatsEntity threadStatsEntity;
  ThreadStatsUIModel(this.threadStatsEntity);

  String get formattedFollowerCount =>
      NumberFormat.compact().format(threadStatsEntity.followerCount);
  String get formattedLikeCount =>
      NumberFormat.compact().format(threadStatsEntity.likeCount);
  String get formattedShareCount =>
      NumberFormat.compact().format(threadStatsEntity.shareCount);
  String get formattedViewCount =>
      NumberFormat.compact().format(threadStatsEntity.viewCount);
  String get formattedCommentCount =>
      NumberFormat.compact().format(threadStatsEntity.commentCount);
  String get formattedBookmarkCount =>
      NumberFormat.compact().format(threadStatsEntity.bookmarkCount);
}
