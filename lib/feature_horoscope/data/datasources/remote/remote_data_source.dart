import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/data/models/horoscope_model.dart';

mixin RemoteDataSource {
  Future<HoroscopeModel> fetchDaily(
      {@required Language language, @required String token});
  Future<HoroscopeModel> fetchWeekly(
      {@required Language language, @required String token});
  Future<HoroscopeModel> fetchMonthly(
      {@required Language language, @required String token});
  Future<HoroscopeModel> fetchYearly(
      {@required Language language, @required String token});

  Future<HoroscopeModel> like(
      {@required String horoscopeId, @required String token});
  Future<HoroscopeModel> unlike(
      {@required String horoscopeId, @required String token});

  Future<HoroscopeModel> dislike(
      {@required String horoscopeId, @required String token});
  Future<HoroscopeModel> undislike(
      {@required String horoscopeId, @required String token});

  Future<HoroscopeModel> share(
      {@required String horoscopeId, @required String token});
  Future<HoroscopeModel> view(
      {@required String horoscopeId, @required String token});
}
