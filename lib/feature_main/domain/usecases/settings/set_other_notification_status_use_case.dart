import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetOtherNotificationStatusUseCase
    implements UseCase<void, SetOtherNotificationUseCaseParams> {
  final Repository _repository;

  SetOtherNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetOtherNotificationUseCaseParams params) {
    try {
      return this._repository.enableOtherNotification(params.value);
    } catch (e) {
      log('SetOtherNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetOtherNotificationUseCaseParams extends Equatable {
  final bool value;

  SetOtherNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
