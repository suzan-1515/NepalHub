import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/domain/repositories/repository.dart';

class LogoutUseCase implements UseCase<UserEntity, LogoutUseCaseParams> {
  final Repository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<UserEntity> call(LogoutUseCaseParams params) {
    try {
      return this._repository.logout(userEntity: params.userEntity);
    } catch (e) {
      log('LogoutUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class LogoutUseCaseParams extends Equatable {
  final UserEntity userEntity;

  LogoutUseCaseParams({
    @required this.userEntity,
  });

  @override
  List<Object> get props => [userEntity];
}
