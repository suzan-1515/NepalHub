import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetDefaultForexCurrencyUseCase
    implements UseCase<void, SetDefaultForexCurrencyUseCaseParams> {
  final Repository _repository;

  SetDefaultForexCurrencyUseCase(this._repository);

  @override
  Future<void> call(SetDefaultForexCurrencyUseCaseParams params) {
    try {
      return this._repository.setDefaultForexCurrency(params.value);
    } catch (e) {
      log('SetDefaultForexCurrencyUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetDefaultForexCurrencyUseCaseParams extends Equatable {
  final String value;

  SetDefaultForexCurrencyUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
