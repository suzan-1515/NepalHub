import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_gold/data/services/remote_service.dart';

class GoldSilverRemoteService with RemoteService {
  static const LIKE = '/gold-silvers/like';
  static const DISLIKE = '/gold-silvers/dislike';
  static const SHARE = '/gold-silvers/share';
  static const VIEW = '/gold-silvers/view';
  static const LATEST = '/gold-silvers/today';
  static const TIMELINE = '/gold-silvers';
  static const CATEGORIES = '/gold-silver-categories';
  final HttpManager _httpManager;

  GoldSilverRemoteService(this._httpManager);

  @override
  Future dislike(
      {@required String goldSilverId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$DISLIKE/$goldSilverId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future fetchLatestGoldSilver(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var call = await _httpManager.get(path: LATEST, headers: headers);

    return call;
  }

  @override
  Future fetchCategories(
      {@required Language language, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> query = {
      'language': language.value,
    };

    var call = await _httpManager.get(
        path: CATEGORIES, query: query, headers: headers);

    return call;
  }

  @override
  Future fetchGoldSilverTimeline(
      {@required String categoryId,
      @required String unit,
      @required Language language,
      @required int numOfDays,
      @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> query = {
      'category.id': categoryId,
      'category.language': language.value,
      'unit': unit,
      '_limit': numOfDays.toString(),
      '_sort': 'publishedAt:DESC',
    };
    var call =
        await _httpManager.get(path: TIMELINE, query: query, headers: headers);

    return call;
  }

  @override
  Future like({@required String goldSilverId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$goldSilverId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future share({@required String goldSilverId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$SHARE/$goldSilverId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future undislike(
      {@required String goldSilverId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$DISLIKE/$goldSilverId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future unlike({@required String goldSilverId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$goldSilverId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future view({@required String goldSilverId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$VIEW/$goldSilverId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }
}
