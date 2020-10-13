import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetPitchBlackModeUseCase
    implements UseCase<void, SetPitchBlackModeUseCaseParams> {
  final Repository _repository;

  SetPitchBlackModeUseCase(this._repository);

  @override
  Future<void> call(SetPitchBlackModeUseCaseParams params) {
    try {
      return this._repository.setPitchBlackMode(params.value);
    } catch (e) {
      log('SetPitchBlackModeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetPitchBlackModeUseCaseParams extends Equatable {
  final bool value;

  SetPitchBlackModeUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
