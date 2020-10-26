import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_horoscope/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_horoscope/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class HoroscopeRepository with Repository {
  final RemoteDataSource _horoscopeRemoteDataSource;
  final LocalDataSource _horoscopeLocalDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  HoroscopeRepository(
      this._horoscopeRemoteDataSource,
      this._horoscopeLocalDataSource,
      this._analyticsService,
      this._authRepository);

  @override
  Future<HoroscopeEntity> dislike(HoroscopeEntity feed) {
    return _horoscopeRemoteDataSource
        .dislike(
      horoscopeId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logHoroscopeDisLike(horoscopeId: feed.id);
      return value;
    });
  }

  @override
  Future<HoroscopeEntity> share(HoroscopeEntity feed) {
    return _horoscopeRemoteDataSource
        .share(
      horoscopeId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logHoroscopeShare(horoscopeId: feed.id);
      return value;
    });
  }

  @override
  Future<HoroscopeEntity> undislike(HoroscopeEntity feed) {
    return _horoscopeRemoteDataSource
        .undislike(
      horoscopeId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logHoroscopeUndisLike(horoscopeId: feed.id);
      return value;
    });
  }

  @override
  Future<HoroscopeEntity> unlike(HoroscopeEntity feed) {
    return _horoscopeRemoteDataSource
        .unlike(
      horoscopeId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logHoroscopeUnlike(horoscopeId: feed.id);
      return value;
    });
  }

  @override
  Future<HoroscopeEntity> view(HoroscopeEntity feed) {
    return _horoscopeRemoteDataSource
        .view(
      horoscopeId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logHoroscopeView(horoscopeId: feed.id);
      return value;
    });
  }

  @override
  Future<HoroscopeEntity> getDaily({@required Language language}) {
    return _horoscopeRemoteDataSource.fetchDaily(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<int> getDefaultHoroscopeSignIndex() async {
    return _horoscopeLocalDataSource.loadDefaultHoroscopeSignIndex();
  }

  @override
  Future<HoroscopeEntity> getMonthly({@required Language language}) {
    return _horoscopeRemoteDataSource.fetchMonthly(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<HoroscopeEntity> getWeekly({@required Language language}) {
    return _horoscopeRemoteDataSource.fetchWeekly(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<HoroscopeEntity> getYearly({@required Language language}) {
    return _horoscopeRemoteDataSource.fetchYearly(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<HoroscopeEntity> like(HoroscopeEntity feed) {
    return _horoscopeRemoteDataSource
        .like(
      horoscopeId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logHoroscopeLike(horoscopeId: feed.id);
      return value;
    });
  }
}
