import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_report/data/models/report_model.dart';

mixin RemoteDataSource {
  Future<ReportModel> postReport(
      {@required String threadId,
      @required String threadType,
      @required String description,
      @required String tag,
      @required String token});
}
