import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_type.dart';

mixin Repository {
  Future<ThreadStatsEntity> getThreadStats(
      {@required String threadId, @required ThreadType threadType});
}
