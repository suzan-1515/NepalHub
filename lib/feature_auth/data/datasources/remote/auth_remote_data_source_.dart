import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_auth/data/models/user_model.dart';
import 'package:samachar_hub/feature_auth/data/services/remote_service.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

class AuthRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  AuthRemoteDataSource(this._remoteService);

  @override
  Future<UserModel> fetchUserProfile({@required String token}) async {
    var userProfileResponse =
        await _remoteService.fetchUserProfile(token: token);
    return UserModel.fromMap(userProfileResponse);
  }

  @override
  Future<UserModel> loginWithEmail(
      {@required String identifier, @required String password}) async {
    var userProfileResponse = await _remoteService.loginWithEmail(
        identifier: identifier, password: password);
    return UserModel.fromMap(userProfileResponse);
  }

  @override
  Future<UserModel> signup({@required String uid}) async {
    var userProfileResponse = await _remoteService.signup(uid: uid);
    return UserModel.fromMap(userProfileResponse);
  }

  @override
  Future<UserModel> loginWithFacebook() async {
    var userProfileResponse = await _remoteService.loginWithFacebook();
    return UserModel.fromMap(userProfileResponse);
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    var userProfileResponse = await _remoteService.loginWithGoogle();
    return UserModel.fromMap(userProfileResponse);
  }

  @override
  Future<UserModel> loginWithTwitter() async {
    var userProfileResponse = await _remoteService.loginWithTwitter();
    return UserModel.fromMap(userProfileResponse);
  }

  @override
  Future<void> logout({@required UserEntity userEntity}) {
    return _remoteService.logout(userEntity: userEntity);
  }
}
