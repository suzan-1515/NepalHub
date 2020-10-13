import 'package:flutter/foundation.dart';

mixin Storage {
  String loadUserToken();
  Future saveUserToken({@required String token});
}
