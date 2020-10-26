import 'package:samachar_hub/feature_report/data/datasources/remote/remote_data_service.dart';
import 'package:samachar_hub/feature_report/data/models/report_model.dart';
import 'package:samachar_hub/feature_report/data/services/remote_service.dart';

class ReportRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  ReportRemoteDataSource(this._remoteService);
  @override
  Future<ReportModel> postReport(
      {String threadId,
      String threadType,
      String description,
      String tag,
      String token}) async {
    var response = await _remoteService.postReport(
        threadId: threadId,
        threadType: threadType,
        description: description,
        tag: tag,
        token: token);

    return ReportModel.fromMap(response);
  }
}
