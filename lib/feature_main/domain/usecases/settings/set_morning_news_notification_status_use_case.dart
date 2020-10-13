import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetMorningNewsNotificationStatusUseCase
    implements UseCase<void, SetMorningNewsNotificationUseCaseParams> {
  final Repository _repository;

  SetMorningNewsNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetMorningNewsNotificationUseCaseParams params) {
    try {
      return this._repository.enableDailyMorningNewsNotification(params.value);
    } catch (e) {
      log('SetMorningNewsNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetMorningNewsNotificationUseCaseParams extends Equatable {
  final bool value;

  SetMorningNewsNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
