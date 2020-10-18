import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';

mixin RemoteService {
  Future fetchDaily({@required Language language, @required String token});
  Future fetchWeekly({@required Language language, @required String token});
  Future fetchMonthly({@required Language language, @required String token});
  Future fetchYearly({@required Language language, @required String token});

  Future like({@required String horoscopeId, @required String token});
  Future unlike({@required String horoscopeId, @required String token});

  Future dislike({@required String horoscopeId, @required String token});
  Future undislike({@required String horoscopeId, @required String token});

  Future share({@required String horoscopeId, @required String token});
  Future view({@required String horoscopeId, @required String token});
}
