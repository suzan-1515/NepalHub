import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_gold/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_category_entity.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class GoldSilverRepository with Repository {
  final RemoteDataSource _goldSilverRemoteDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  GoldSilverRepository(this._goldSilverRemoteDataSource, this._analyticsService,
      this._authRepository);

  @override
  Future<GoldSilverEntity> dislike(GoldSilverEntity feed) {
    return _goldSilverRemoteDataSource
        .dislike(
      goldSilverId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logGoldSilverDisLike(goldSilverId: feed.id);
      return value;
    });
  }

  @override
  Future<List<GoldSilverCategoryEntity>> getCategories(
      {@required Language language}) {
    return _goldSilverRemoteDataSource.fetchCategories(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<GoldSilverEntity>> getGoldSilverTimeline(
      {@required String categoryId,
      @required String unit,
      @required Language language,
      @required int numOfDays}) {
    return _goldSilverRemoteDataSource.fetchGoldSilverTimeline(
      categoryId: categoryId,
      unit: unit,
      numOfDays: numOfDays,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<GoldSilverEntity>> getLatestGoldSilver(
      {@required Language language}) {
    return _goldSilverRemoteDataSource.fetchLatestGoldSilver(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<GoldSilverEntity> like(GoldSilverEntity feed) {
    return _goldSilverRemoteDataSource
        .like(
      goldSilverId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logGoldSilverLike(goldSilverId: feed.id);
      return value;
    });
  }

  @override
  Future<GoldSilverEntity> share(GoldSilverEntity feed) {
    return _goldSilverRemoteDataSource
        .share(
      goldSilverId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logGoldSilverShare(goldSilverId: feed.id);
      return value;
    });
  }

  @override
  Future<GoldSilverEntity> undislike(GoldSilverEntity feed) {
    return _goldSilverRemoteDataSource
        .undislike(
      goldSilverId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logGoldSilverUndisLike(goldSilverId: feed.id);
      return value;
    });
  }

  @override
  Future<GoldSilverEntity> unlike(GoldSilverEntity feed) {
    return _goldSilverRemoteDataSource
        .unlike(
      goldSilverId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logGoldSilverUnlike(goldSilverId: feed.id);
      return value;
    });
  }

  @override
  Future<GoldSilverEntity> view(GoldSilverEntity feed) {
    return _goldSilverRemoteDataSource
        .view(
      goldSilverId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logGoldSilverView(goldSilverId: feed.id);
      return value;
    });
  }
}
