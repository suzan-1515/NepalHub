import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';

mixin RemoteService {
  Future fetchLatestGoldSilver(
      {@required Language language, @required String token});
  Future fetchGoldSilverTimeline(
      {@required String categoryId,
      @required String unit,
      Language language,
      @required int numOfDays,
      @required String token});
  Future fetchCategories({@required Language language, @required String token});
  Future like({@required String goldSilverId, @required String token});
  Future unlike({@required String goldSilverId, @required String token});

  Future dislike({@required String goldSilverId, @required String token});
  Future undislike({@required String goldSilverId, @required String token});

  Future share({@required String goldSilverId, @required String token});
  Future view({@required String goldSilverId, @required String token});
}
