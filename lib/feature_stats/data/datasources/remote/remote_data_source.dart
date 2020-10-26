import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_stats/data/models/thread_stats_model.dart';

mixin RemoteDataSource {
  Future<ThreadStatsModel> fetchStats(
      {@required String threadId,
      @required String threadType,
      @required String token});
}
