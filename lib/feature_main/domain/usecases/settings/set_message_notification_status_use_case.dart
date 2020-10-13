import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetMessageNotificationStatusUseCase
    implements UseCase<void, SetMessageNotificationUseCaseParams> {
  final Repository _repository;

  SetMessageNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetMessageNotificationUseCaseParams params) {
    try {
      return this._repository.enableMessageNotification(params.value);
    } catch (e) {
      log('SetMessageNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetMessageNotificationUseCaseParams extends Equatable {
  final bool value;

  SetMessageNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
