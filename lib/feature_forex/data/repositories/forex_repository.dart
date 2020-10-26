import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_forex/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_forex/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class ForexRepository with Repository {
  final RemoteDataSource _forexRemoteDataSource;
  final LocalDataSource _forexLocalDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  ForexRepository(this._forexRemoteDataSource, this._forexLocalDataSource,
      this._analyticsService, this._authRepository);

  @override
  Future<ForexEntity> dislike(ForexEntity feed) {
    return _forexRemoteDataSource
        .dislike(
      forexId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logForexDisLike(forexId: feed.id);
      return value;
    });
  }

  @override
  Future<List<CurrencyEntity>> getCurrencies({@required Language language}) {
    return _forexRemoteDataSource.fetchCurrencies(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<ForexEntity>> getForexTimeline(
      {@required String currencyId,
      @required Language language,
      @required int numOfDays}) {
    return _forexRemoteDataSource.fetchForexTimeline(
      currencyId: currencyId,
      numOfDays: numOfDays,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<ForexEntity>> getLatestForex({@required Language language}) {
    return _forexRemoteDataSource.fetchLatestForex(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<ForexEntity> like(ForexEntity feed) {
    return _forexRemoteDataSource
        .like(
      forexId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logForexLike(forexId: feed.id);
      return value;
    });
  }

  @override
  Future<ForexEntity> share(ForexEntity feed) {
    return _forexRemoteDataSource
        .share(
      forexId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logForexShare(forexId: feed.id);
      return value;
    });
  }

  @override
  Future<ForexEntity> undislike(ForexEntity feed) {
    return _forexRemoteDataSource
        .undislike(
      forexId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logForexUndisLike(forexId: feed.id);
      return value;
    });
  }

  @override
  Future<ForexEntity> unlike(ForexEntity feed) {
    return _forexRemoteDataSource
        .unlike(
      forexId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logForexUnlike(forexId: feed.id);
      return value;
    });
  }

  @override
  Future<ForexEntity> view(ForexEntity feed) {
    return _forexRemoteDataSource
        .view(
      forexId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logForexView(forexId: feed.id);
      return value;
    });
  }

  @override
  Future<String> getDefaultCurrencyCode() async {
    return _forexLocalDataSource.loadDefaultForexCurrencyCode();
  }
}
