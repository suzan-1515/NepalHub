import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SetCommentNotificationStatusUseCase
    implements UseCase<void, SetCommentNotificationUseCaseParams> {
  final Repository _repository;

  SetCommentNotificationStatusUseCase(this._repository);

  @override
  Future<void> call(SetCommentNotificationUseCaseParams params) {
    try {
      return this._repository.enableCommentNotification(params.value);
    } catch (e) {
      log('SetCommentNotificationUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class SetCommentNotificationUseCaseParams extends Equatable {
  final bool value;

  SetCommentNotificationUseCaseParams({
    @required this.value,
  });

  @override
  List<Object> get props => [value];
}
