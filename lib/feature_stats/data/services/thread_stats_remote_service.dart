import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_stats/data/services/remote_service.dart';

class ThreadStatsRemoteService with RemoteService {
  static const STATS = '/thread-overall-stats';
  final HttpManager _httpManager;

  ThreadStatsRemoteService(this._httpManager);
  @override
  Future fetchStats({String threadId, String threadType, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> query = {
      'thread_id': threadId,
      'thread_type': threadType,
    };

    return _httpManager.get(path: STATS, headers: headers, query: query);
  }
}
