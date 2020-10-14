import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/data/models/currency_model.dart';
import 'package:samachar_hub/feature_forex/data/models/forex_model.dart';

mixin RemoteDataSource {
  Future<List<ForexModel>> fetchLatestForex(
      {@required Language language, @required String token});
  Future<List<ForexModel>> fetchForexTimeline(
      {@required String currencyId,
      @required Language language,
      @required int numOfDays,
      @required String token});
  Future<List<ForexCurrencyModel>> fetchCurrencies(
      {@required Language language, @required String token});
  Future<ForexModel> like({@required String forexId, @required String token});
  Future<ForexModel> unlike({@required String forexId, @required String token});

  Future<ForexModel> dislike(
      {@required String forexId, @required String token});
  Future<ForexModel> undislike(
      {@required String forexId, @required String token});

  Future<ForexModel> share({@required String forexId, @required String token});
  Future<ForexModel> view({@required String forexId, @required String token});
}
