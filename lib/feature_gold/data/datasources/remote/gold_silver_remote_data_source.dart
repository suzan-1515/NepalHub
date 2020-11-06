import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_gold/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_gold/data/models/gold_silver_category.dart';
import 'package:samachar_hub/feature_gold/data/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/data/services/remote_service.dart';

class GoldSilverRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  GoldSilverRemoteDataSource(this._remoteService);

  @override
  Future<GoldSilverModel> dislike(
      {@required String goldSilverId, @required String token}) async {
    var response =
        await _remoteService.dislike(goldSilverId: goldSilverId, token: token);
    return GoldSilverModel.fromMap(response);
  }

  @override
  Future<List<GoldSilverCategoryModel>> fetchCategories(
      {@required Language language, @required String token}) async {
    var response =
        await _remoteService.fetchCategories(language: language, token: token);
    final List<GoldSilverCategoryModel> currencies = response
        .map<GoldSilverCategoryModel>((e) => GoldSilverCategoryModel.fromMap(e))
        .toList();
    return currencies;
  }

  @override
  Future<List<GoldSilverModel>> fetchGoldSilverTimeline(
      {@required String categoryId,
      @required String unit,
      @required Language language,
      @required int numOfDays,
      @required String token}) async {
    var response = await _remoteService.fetchGoldSilverTimeline(
      categoryId: categoryId,
      unit: unit,
      language: language,
      numOfDays: numOfDays,
      token: token,
    );
    final List<GoldSilverModel> goldSilverList = response
        .map<GoldSilverModel>((e) => GoldSilverModel.fromMap(e))
        .toList();
    return goldSilverList;
  }

  @override
  Future<List<GoldSilverModel>> fetchLatestGoldSilver(
      {@required Language language, @required String token}) async {
    var response = await _remoteService.fetchLatestGoldSilver(
      language: language,
      token: token,
    );
    final List<GoldSilverModel> goldSilverList = response
        .map<GoldSilverModel>((e) => GoldSilverModel.fromMap(e))
        .toList();
    return goldSilverList;
  }

  @override
  Future<GoldSilverModel> like(
      {@required String goldSilverId, @required String token}) async {
    var response = await _remoteService.like(
      goldSilverId: goldSilverId,
      token: token,
    );
    return GoldSilverModel.fromMap(response);
  }

  @override
  Future<GoldSilverModel> share(
      {@required String goldSilverId, @required String token}) async {
    var response = await _remoteService.share(
      goldSilverId: goldSilverId,
      token: token,
    );
    return GoldSilverModel.fromMap(response);
  }

  @override
  Future<GoldSilverModel> undislike(
      {@required String goldSilverId, @required String token}) async {
    var response = await _remoteService.undislike(
        goldSilverId: goldSilverId, token: token);
    return GoldSilverModel.fromMap(response);
  }

  @override
  Future<GoldSilverModel> unlike(
      {@required String goldSilverId, @required String token}) async {
    var response = await _remoteService.unlike(
      goldSilverId: goldSilverId,
      token: token,
    );
    return GoldSilverModel.fromMap(response);
  }

  @override
  Future<GoldSilverModel> view(
      {@required String goldSilverId, @required String token}) async {
    var response = await _remoteService.view(
      goldSilverId: goldSilverId,
      token: token,
    );
    return GoldSilverModel.fromMap(response);
  }
}
