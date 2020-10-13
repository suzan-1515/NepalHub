import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

mixin RemoteService {
  Future<dynamic> loginWithGoogle();
  Future<dynamic> loginWithFacebook();
  Future<dynamic> loginWithTwitter();
  Future<dynamic> logout({@required UserEntity userEntity});
  Future<dynamic> signup({@required String uid});
  Future<dynamic> loginWithEmail(
      {@required String identifier, @required String password});
  Future<dynamic> fetchUserProfile({@required String token});
}
