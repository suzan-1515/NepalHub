import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetNewsNotificationStatusUseCase
    implements UseCase<void, SetNewsNotificationUseCaseParams> {
  final Repository _repository;

  SetNewsNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetNewsNotificationUseCaseParams params) {
    try {
      return this._repository.enableNewsNotification(params.value);
    } catch (e) {
      log('SetNewsNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetNewsNotificationUseCaseParams extends Equatable {
  final bool value;

  SetNewsNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
