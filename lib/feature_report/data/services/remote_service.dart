import 'package:flutter/foundation.dart';

mixin RemoteService {
  Future postReport(
      {@required String threadId,
      @required String threadType,
      @required String description,
      @required String tag,
      @required String token});
}
