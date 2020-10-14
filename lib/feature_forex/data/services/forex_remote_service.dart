import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_forex/data/services/remote_service.dart';

class ForexRemoteService with RemoteService {
  static const LIKE = '/forexes/like';
  static const SHARE = '/forexes/share';
  static const VIEW = '/forexes/view';
  static const LATEST = '/forexes/today';
  static const TIMELINE = '/forexes';
  static const CURRENCY = '/forex-currencies';
  final HttpManager _httpManager;

  ForexRemoteService(this._httpManager);

  @override
  Future dislike({@required String forexId, @required String token}) {
    // TODO: implement dislike
    throw UnimplementedError();
  }

  @override
  Future fetchLatestForex(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> query = {
      'language': language.value,
    };

    var call =
        await _httpManager.get(path: LATEST, query: query, headers: headers);

    return call;
  }

  @override
  Future fetchCurrencies(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> query = {
      'language': language.value,
    };

    var call =
        await _httpManager.get(path: CURRENCY, query: query, headers: headers);

    return call;
  }

  @override
  Future fetchForexTimeline(
      {@required String currencyId,
      @required Language language,
      @required int numOfDays,
      @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> query = {
      'currency.id': currencyId,
      'currency.language': language.value,
      '_limit': numOfDays,
    };
    var call =
        await _httpManager.get(path: TIMELINE, query: query, headers: headers);

    return call;
  }

  @override
  Future like({@required String forexId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$forexId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future share({@required String forexId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$SHARE/$forexId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future undislike({@required String forexId, @required String token}) {
    // TODO: implement undislike
    throw UnimplementedError();
  }

  @override
  Future unlike({@required String forexId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$forexId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future view({@required String forexId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$VIEW/$forexId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }
}
