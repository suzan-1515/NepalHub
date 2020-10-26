import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_horoscope/data/services/remote_service.dart';

class HoroscopeRemoteService with RemoteService {
  static const LIKE = '/horoscopes/like';
  static const DISLIKE = '/horoscopes/dislike';
  static const SHARE = '/horoscopes/share';
  static const VIEW = '/horoscopes/view';
  static const TODAY = '/horoscopes/today';
  static const WEEKLY = '/horoscopes/weekly';
  static const MONTHLY = '/horoscopes/monthly';
  static const YEARLY = '/horoscopes/yearly';
  final HttpManager _httpManager;

  HoroscopeRemoteService(this._httpManager);

  @override
  Future like({@required String horoscopeId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$horoscopeId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future share({@required String horoscopeId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$SHARE/$horoscopeId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future undislike(
      {@required String horoscopeId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$DISLIKE/$horoscopeId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future unlike({@required String horoscopeId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$horoscopeId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future view({@required String horoscopeId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$VIEW/$horoscopeId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future fetchDaily(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var call = await _httpManager.get(path: TODAY, headers: headers);

    return call;
  }

  @override
  Future fetchMonthly(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var call = await _httpManager.get(path: MONTHLY, headers: headers);

    return call;
  }

  @override
  Future fetchWeekly(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var call = await _httpManager.get(path: WEEKLY, headers: headers);

    return call;
  }

  @override
  Future fetchYearly(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var call = await _httpManager.get(path: YEARLY, headers: headers);

    return call;
  }

  @override
  Future dislike({String horoscopeId, String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$DISLIKE/$horoscopeId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }
}
