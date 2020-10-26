import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_entity.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';

mixin Repository {
  Future<ReportEntity> reportPost(
      {@required String threadId,
      @required ReportThreadType threadType,
      @required String tag,
      String description});
}
