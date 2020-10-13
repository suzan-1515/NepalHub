import 'package:meta/meta.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

mixin Repository {
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> loginWithFacebook();
  Future<UserEntity> loginWithTwitter();
  Future<UserEntity> logout({@required UserEntity userEntity});
}
