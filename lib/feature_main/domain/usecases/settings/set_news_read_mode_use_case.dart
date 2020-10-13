import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetNewsReadModeUseCase
    implements UseCase<void, SetNewsReadModeUseCaseParams> {
  final Repository _repository;

  SetNewsReadModeUseCase(this._repository);

  @override
  Future<void> call(SetNewsReadModeUseCaseParams params) {
    try {
      return this._repository.setNewsReadMode(params.value);
    } catch (e) {
      log('SetNewsReadModeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetNewsReadModeUseCaseParams extends Equatable {
  final int value;

  SetNewsReadModeUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
