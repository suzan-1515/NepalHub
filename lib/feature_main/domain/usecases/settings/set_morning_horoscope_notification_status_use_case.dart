import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetMorningHoroscopeNotificationStatusUseCase
    implements UseCase<void, SetMorningHoroscopeNotificationUseCaseParams> {
  final Repository _repository;

  SetMorningHoroscopeNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetMorningHoroscopeNotificationUseCaseParams params) {
    try {
      return this
          ._repository
          .enableDailyMorningHoroscopeNotification(params.value);
    } catch (e) {
      log('SetMorningHoroscopeNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetMorningHoroscopeNotificationUseCaseParams extends Equatable {
  final bool value;

  SetMorningHoroscopeNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
