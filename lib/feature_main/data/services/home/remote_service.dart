import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';

mixin RemoteService {
  Future fetchHomeFeed(
      {@required Language language,
      @required String defaultForexCurrencyCode,
      @required String token});
}
