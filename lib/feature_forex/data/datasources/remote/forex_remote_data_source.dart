import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_forex/data/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/data/models/currency_model.dart';
import 'package:samachar_hub/feature_forex/data/services/remote_service.dart';

class ForexRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  ForexRemoteDataSource(this._remoteService);

  @override
  Future<ForexModel> dislike(
      {@required String forexId, @required String token}) {
    throw UnimplementedError();
  }

  @override
  Future<List<ForexCurrencyModel>> fetchCurrencies(
      {@required Language language, @required String token}) async {
    var response =
        await _remoteService.fetchCurrencies(language: language, token: token);
    var currencies =
        response.map((e) => ForexCurrencyModel.fromMap(e)).toList();
    return currencies;
  }

  @override
  Future<List<ForexModel>> fetchForexTimeline(
      {@required String currencyId,
      @required Language language,
      @required int numOfDays,
      @required String token}) async {
    var response = await _remoteService.fetchForexTimeline(
      currencyId: currencyId,
      language: language,
      numOfDays: numOfDays,
      token: token,
    );
    var forexList = response.map((e) => ForexModel.fromMap(e)).toList();
    return forexList;
  }

  @override
  Future<List<ForexModel>> fetchLatestForex(
      {@required Language language, @required String token}) async {
    var response = await _remoteService.fetchLatestForex(
      language: language,
      token: token,
    );
    var forexList = response.map((e) => ForexModel.fromMap(e)).toList();
    return forexList;
  }

  @override
  Future<ForexModel> like(
      {@required String forexId, @required String token}) async {
    var response = await _remoteService.like(
      forexId: forexId,
      token: token,
    );
    return ForexModel.fromMap(response);
  }

  @override
  Future<ForexModel> share(
      {@required String forexId, @required String token}) async {
    var response = await _remoteService.share(
      forexId: forexId,
      token: token,
    );
    return ForexModel.fromMap(response);
  }

  @override
  Future<ForexModel> undislike(
      {@required String forexId, @required String token}) async {
    throw UnimplementedError();
  }

  @override
  Future<ForexModel> unlike(
      {@required String forexId, @required String token}) async {
    var response = await _remoteService.unlike(
      forexId: forexId,
      token: token,
    );
    return ForexModel.fromMap(response);
  }

  @override
  Future<ForexModel> view(
      {@required String forexId, @required String token}) async {
    var response = await _remoteService.view(
      forexId: forexId,
      token: token,
    );
    return ForexModel.fromMap(response);
  }
}
