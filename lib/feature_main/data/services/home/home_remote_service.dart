import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_main/data/services/home/remote_service.dart';

class HomeRemoteService with RemoteService {
  static const String HOME = '/home';
  final HttpManager _httpManager;

  HomeRemoteService(this._httpManager);

  @override
  Future fetchHomeFeed(
      {@required Language language,
      @required String defaultForexCurrencyCode,
      @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> query = {
      'language': language?.value,
      'forex_currency_code': defaultForexCurrencyCode,
    };
    var call =
        await _httpManager.get(path: HOME, headers: headers, query: query);
    return call;
  }
}
