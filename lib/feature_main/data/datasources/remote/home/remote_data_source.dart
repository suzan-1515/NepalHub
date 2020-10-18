import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/data/models/home_model.dart';

mixin RemoteDataSource {
  Future<HomeModel> fetchHomeFeed(
      {@required Language language, @required String token});
}
