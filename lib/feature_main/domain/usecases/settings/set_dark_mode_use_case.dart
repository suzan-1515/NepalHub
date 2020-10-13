import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetDarkModeUseCase implements UseCase<void, SetDarkModeUseCaseParams> {
  final Repository _repository;

  SetDarkModeUseCase(this._repository);

  @override
  Future<void> call(SetDarkModeUseCaseParams params) {
    try {
      return this._repository.setDarkMode(params.value);
    } catch (e) {
      log('SetDarkModeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetDarkModeUseCaseParams extends Equatable {
  final bool value;

  SetDarkModeUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
