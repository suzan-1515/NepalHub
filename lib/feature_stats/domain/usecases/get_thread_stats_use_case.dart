import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_stats/domain/repositories/repository.dart';

class GetThreadStatsUseCase
    implements UseCase<ThreadStatsEntity, GetThreadStatsUseCaseParams> {
  final Repository _repository;

  GetThreadStatsUseCase(this._repository);

  @override
  Future<ThreadStatsEntity> call(GetThreadStatsUseCaseParams params) {
    try {
      return this._repository.getThreadStats(
          threadId: params.threadId, threadType: params.threadType);
    } catch (e) {
      log('GetThreadStatsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetThreadStatsUseCaseParams extends Equatable {
  final String threadId;
  final ThreadType threadType;

  GetThreadStatsUseCaseParams({
    @required this.threadId,
    @required this.threadType,
  });

  @override
  List<Object> get props => [threadId, threadType];
}
