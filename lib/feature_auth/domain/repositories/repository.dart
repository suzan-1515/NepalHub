import 'package:meta/meta.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

mixin Repository {
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> loginWithFacebook();
  Future<UserEntity> loginWithTwitter();
  Future<UserEntity> autoLogin();
  Future<void> logout({@required UserEntity userEntity});
  Future<UserEntity> getUserProfile();
  String getUserToken();
}
