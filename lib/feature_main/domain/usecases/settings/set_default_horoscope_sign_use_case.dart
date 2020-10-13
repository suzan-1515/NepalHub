import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetDefaultHoroscopeSignUseCase
    implements UseCase<void, SetDefaultHoroscopeSignUseCaseParams> {
  final Repository _repository;

  SetDefaultHoroscopeSignUseCase(this._repository);

  @override
  Future<void> call(SetDefaultHoroscopeSignUseCaseParams params) {
    try {
      return this._repository.setDefaultHoroscopeSign(params.value);
    } catch (e) {
      log('SetDefaultHoroscopeSignUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetDefaultHoroscopeSignUseCaseParams extends Equatable {
  final int value;

  SetDefaultHoroscopeSignUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
