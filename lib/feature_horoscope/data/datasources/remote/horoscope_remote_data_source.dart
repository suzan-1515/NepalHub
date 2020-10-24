import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_horoscope/data/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/data/services/remote_service.dart';

class HoroscopeRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  HoroscopeRemoteDataSource(this._remoteService);

  @override
  Future<HoroscopeModel> dislike(
      {@required String horoscopeId, @required String token}) async {
    var response =
        await _remoteService.dislike(horoscopeId: horoscopeId, token: token);
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> like(
      {@required String horoscopeId, @required String token}) async {
    var response = await _remoteService.like(
      horoscopeId: horoscopeId,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> share(
      {@required String horoscopeId, @required String token}) async {
    var response = await _remoteService.share(
      horoscopeId: horoscopeId,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> undislike(
      {@required String horoscopeId, @required String token}) async {
    var response =
        await _remoteService.undislike(horoscopeId: horoscopeId, token: token);
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> unlike(
      {@required String horoscopeId, @required String token}) async {
    var response = await _remoteService.unlike(
      horoscopeId: horoscopeId,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> view(
      {@required String horoscopeId, @required String token}) async {
    var response = await _remoteService.view(
      horoscopeId: horoscopeId,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> fetchDaily(
      {@required Language language, @required String token}) async {
    var response = await _remoteService.fetchDaily(
      language: language,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> fetchMonthly(
      {@required Language language, @required String token}) async {
    var response = await _remoteService.fetchMonthly(
      language: language,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> fetchWeekly(
      {@required Language language, @required String token}) async {
    var response = await _remoteService.fetchWeekly(
      language: language,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }

  @override
  Future<HoroscopeModel> fetchYearly(
      {@required Language language, @required String token}) async {
    var response = await _remoteService.fetchYearly(
      language: language,
      token: token,
    );
    return HoroscopeModel.fromMap(response);
  }
}
