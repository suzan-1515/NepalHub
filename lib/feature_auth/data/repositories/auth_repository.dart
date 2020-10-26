import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_auth/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/domain/repositories/repository.dart';

class AuthRepository with Repository {
  final RemoteDataSource _authRemoteDataSource;
  final LocalDataSource _authLocalDataSource;
  final AnalyticsService _analyticsService;

  AuthRepository(this._authRemoteDataSource, this._analyticsService,
      this._authLocalDataSource);

  @override
  Future<UserEntity> loginWithFacebook() {
    return _authRemoteDataSource.loginWithFacebook().then((value) async {
      await _authLocalDataSource.saveUserToken(token: value.token);
      if (value.isNew)
        _analyticsService.logSignUp(method: 'facebook');
      else
        _analyticsService.logLogin(method: 'facebook');

      return value;
    });
  }

  @override
  Future<UserEntity> loginWithGoogle() {
    return _authRemoteDataSource.loginWithGoogle().then((value) async {
      await _authLocalDataSource.saveUserToken(token: value.token);
      if (value.isNew)
        _analyticsService.logSignUp(method: 'google');
      else
        _analyticsService.logLogin(method: 'google');

      return value;
    });
  }

  @override
  Future<UserEntity> loginWithTwitter() {
    return _authRemoteDataSource.loginWithTwitter().then((value) async {
      await _authLocalDataSource.saveUserToken(token: value.token);
      if (value.isNew)
        _analyticsService.logSignUp(method: 'twitter');
      else
        _analyticsService.logLogin(method: 'twitter');

      return value;
    });
  }

  @override
  Future<void> logout({@required UserEntity userEntity}) {
    return _authRemoteDataSource
        .logout(userEntity: userEntity)
        .then((value) async {
      await _authLocalDataSource.saveUserToken(token: '');
      _analyticsService.logLogout();
      return value;
    });
  }

  @override
  Future<UserEntity> getUserProfile() {
    var token = _authLocalDataSource.loadUserToken();
    return _authRemoteDataSource.fetchUserProfile(token: token);
  }

  @override
  String getUserToken() {
    return _authLocalDataSource.loadUserToken();
  }

  @override
  Future<UserEntity> autoLogin() {
    return _authRemoteDataSource.autoLogin().then((value) async {
      await _authLocalDataSource.saveUserToken(token: value.token);
      return value;
    });
  }
}
