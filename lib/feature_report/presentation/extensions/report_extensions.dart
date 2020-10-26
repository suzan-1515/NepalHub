import 'package:samachar_hub/feature_report/domain/entities/report_entity.dart';
import 'package:samachar_hub/feature_report/presentation/models/report_model.dart';

extension ReportEntityX on ReportEntity {
  ReportUIModel get toUIModel => ReportUIModel(this);
}
