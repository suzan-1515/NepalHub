import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/exceptions/app_exceptions.dart';
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
    userProfileResponse['user']['jwt'] = userProfileResponse['jwt'];
    userProfileResponse['user']['is_new'] = true;
    userProfileResponse['user']['is_anonymous'] = false;
    return UserModel.fromMap(userProfileResponse['user']);
  }

  @override
  Future<UserModel> signup({@required String uid}) async {
    var userProfileResponse = await _remoteService.signup(uid: uid);
    userProfileResponse['user']['jwt'] = userProfileResponse['jwt'];
    userProfileResponse['user']['is_new'] = true;
    userProfileResponse['user']['is_anonymous'] = false;
    return UserModel.fromMap(userProfileResponse['user']);
  }

  @override
  Future<UserModel> loginWithFacebook() async {
    UserCredential userCredential = await _remoteService.loginWithFacebook();
    UserModel userModel;
    if (userCredential.additionalUserInfo.isNewUser)
      userModel = await signup(
        uid: userCredential.user.uid,
      );
    else
      userModel = await login(uid: userCredential.user.uid);
    return userModel;
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    UserCredential userCredential = await _remoteService.loginWithGoogle();
    UserModel userModel;
    if (userCredential.additionalUserInfo.isNewUser)
      userModel = await signup(
        uid: userCredential.user.uid,
      );
    else
      userModel = await login(uid: userCredential.user.uid);
    return userModel;
  }

  @override
  Future<UserModel> loginWithTwitter() async {
    UserCredential userCredential = await _remoteService.loginWithTwitter();
    UserModel userModel;
    if (userCredential.additionalUserInfo.isNewUser)
      userModel = await signup(
        uid: userCredential.user.uid,
      );
    else
      userModel = await login(uid: userCredential.user.uid);
    return userModel;
  }

  @override
  Future<void> logout({@required UserEntity userEntity}) {
    return _remoteService.logout(userEntity: userEntity);
  }

  @override
  Future<UserModel> autoLogin() async {
    final User user = await _remoteService.fetchCurrentUser();
    if (user == null) throw UnAuthenticatedException();
    await user.getIdToken();
    return login(uid: user.uid);
  }

  @override
  Future<UserModel> login({String uid}) async {
    var userProfileResponse = await _remoteService.login(uid: uid);
    userProfileResponse['user']['jwt'] = userProfileResponse['jwt'];
    userProfileResponse['user']['is_new'] = false;
    userProfileResponse['user']['is_anonymous'] = false;
    return UserModel.fromMap(userProfileResponse['user']);
  }
}
