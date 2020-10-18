import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_main/data/datasources/remote/home/remote_data_source.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/domain/repositories/home/repository.dart';

class HomeRepository with Repository {
  final RemoteDataSource _remoteDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  HomeRepository(
      this._remoteDataSource, this._analyticsService, this._authRepository);
  @override
  Future<HomeEntity> getHomeFeed({@required Language language}) {
    return _remoteDataSource.fetchHomeFeed(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }
}
