import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetSystemThemeUseCase
    implements UseCase<void, SetSystemThemeUseCaseParams> {
  final Repository _repository;

  SetSystemThemeUseCase(this._repository);

  @override
  Future<void> call(SetSystemThemeUseCaseParams params) {
    try {
      return this._repository.setSystemTheme(params.value);
    } catch (e) {
      log('SetSystemThemeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetSystemThemeUseCaseParams extends Equatable {
  final bool value;

  SetSystemThemeUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
