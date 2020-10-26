import 'package:samachar_hub/feature_stats/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_stats/data/models/thread_stats_model.dart';
import 'package:samachar_hub/feature_stats/data/services/remote_service.dart';

class ThreadStatsRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  ThreadStatsRemoteDataSource(this._remoteService);
  @override
  Future<ThreadStatsModel> fetchStats(
      {String threadId, String threadType, String token}) async {
    var response = await _remoteService.fetchStats(
        threadId: threadId, threadType: threadType, token: token);

    return ThreadStatsModel.fromMap(response);
  }
}
