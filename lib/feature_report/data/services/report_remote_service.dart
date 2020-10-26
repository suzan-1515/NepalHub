import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_report/data/services/remote_service.dart';

class ReportRemoteService with RemoteService {
  static const String REPORT = '/reports';
  final HttpManager _httpManager;

  ReportRemoteService(this._httpManager);
  @override
  Future postReport(
      {String threadId,
      String threadType,
      String description,
      String tag,
      String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'thread_id': threadId,
      'thread_type': threadType,
      'description': description,
      'tag': tag,
    };

    return _httpManager.post(path: REPORT, headers: headers, body: body);
  }
}
