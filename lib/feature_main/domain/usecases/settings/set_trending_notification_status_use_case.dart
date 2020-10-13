import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetTrendingNotificationStatusUseCase
    implements UseCase<void, SetTrendingNotificationUseCaseParams> {
  final Repository _repository;

  SetTrendingNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetTrendingNotificationUseCaseParams params) {
    try {
      return this._repository.enableTrendingNotification(params.value);
    } catch (e) {
      log('SetTrendingNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetTrendingNotificationUseCaseParams extends Equatable {
  final bool value;

  SetTrendingNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
