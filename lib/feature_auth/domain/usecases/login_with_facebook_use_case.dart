import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/domain/repositories/repository.dart';

class LoginWithFacebookUseCase implements UseCase<UserEntity, NoParams> {
  final Repository _repository;

  LoginWithFacebookUseCase(this._repository);

  @override
  Future<UserEntity> call(NoParams params) {
    try {
      return this._repository.loginWithFacebook();
    } catch (e) {
      log('LoginWithFacebookUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
