import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/data/models/user_model.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

mixin RemoteDataSource {
  Future<UserModel> autoLogin();
  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginWithFacebook();
  Future<UserModel> loginWithTwitter();
  Future<void> logout({@required UserEntity userEntity});
  Future<UserModel> signup({@required String uid});
  Future<UserModel> loginWithEmail(
      {@required String identifier, @required String password});
  Future<UserModel> login({@required String uid});
  Future<UserModel> fetchUserProfile({@required String token});
}
