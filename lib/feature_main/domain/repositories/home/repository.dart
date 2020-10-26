import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';

mixin Repository {
  Future<HomeEntity> getHomeFeed(
      {@required Language language, String defaultForexCurrencyCode});
  // Future<WeatherEntity> getWeather({@required Language language});
}
