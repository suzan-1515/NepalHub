import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';

mixin RemoteService {
  Future fetchLatestForex(
      {@required Language language, @required String token});
  Future fetchForexTimeline(
      {@required String currencyId,
      Language language,
      @required int numOfDays,
      @required String token});
  Future fetchCurrencies({@required Language language, @required String token});
  Future like({@required String forexId, @required String token});
  Future unlike({@required String forexId, @required String token});

  Future dislike({@required String forexId, @required String token});
  Future undislike({@required String forexId, @required String token});

  Future share({@required String forexId, @required String token});
  Future view({@required String forexId, @required String token});
}
