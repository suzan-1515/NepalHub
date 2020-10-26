import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_stats/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';
import 'package:samachar_hub/feature_stats/domain/repositories/repository.dart';

class ThreadStatsRepository with Repository {
  final RemoteDataSource _remoteDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  ThreadStatsRepository(
      this._remoteDataSource, this._analyticsService, this._authRepository);
  @override
  Future<ThreadStatsEntity> getThreadStats(
      {String threadId, ThreadType threadType}) {
    return _remoteDataSource.fetchStats(
        threadId: threadId,
        threadType: threadType.value,
        token: _authRepository.getUserToken());
  }
}
