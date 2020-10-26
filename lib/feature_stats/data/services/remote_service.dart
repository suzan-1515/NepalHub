import 'package:flutter/foundation.dart';

mixin RemoteService {
  Future fetchStats(
      {@required String threadId,
      @required String threadType,
      @required String token});
}
