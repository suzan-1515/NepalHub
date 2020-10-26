import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/data/datasources/remote/home/remote_data_source.dart';
import 'package:samachar_hub/feature_main/data/models/home_model.dart';
import 'package:samachar_hub/feature_main/data/services/home/remote_service.dart';

class HomeRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  HomeRemoteDataSource(this._remoteService);

  @override
  Future<HomeModel> fetchHomeFeed(
      {@required Language language,
      String defaultForexCurrencyCode,
      @required String token}) async {
    var response = await _remoteService.fetchHomeFeed(
        language: language,
        defaultForexCurrencyCode: defaultForexCurrencyCode,
        token: token);
    var feed = HomeModel.fromMap(response);
    return feed;
  }
}
