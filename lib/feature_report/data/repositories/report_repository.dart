import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_report/data/datasources/remote/remote_data_service.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_entity.dart';
import 'package:samachar_hub/feature_report/domain/repositories/repository.dart';

class ReportRepository with Repository {
  final RemoteDataSource _remoteDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  ReportRepository(
      this._remoteDataSource, this._analyticsService, this._authRepository);
  @override
  Future<ReportEntity> reportPost(
      {String threadId,
      ReportThreadType threadType,
      String tag,
      String description}) {
    return _remoteDataSource
        .postReport(
            threadId: threadId,
            threadType: threadType.value,
            description: description,
            tag: tag,
            token: _authRepository.getUserToken())
        .then((value) {
      _analyticsService.logReportPost(reportId: value.id);
      return value;
    });
  }
}
