import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_stats/domain/usecases/get_thread_stats_use_case.dart';
import 'package:samachar_hub/feature_stats/presentation/models/thread_stats_model.dart';
import 'package:samachar_hub/feature_stats/presentation/extensions/thread_stats_extensions.dart';

part 'thread_stats_state.dart';

class ThreadStatsCubit extends Cubit<ThreadStatsState> {
  final UseCase _getThreadStatsUseCase;
  final String _threadId;
  final ThreadType _threadType;
  ThreadStatsCubit(
      {@required UseCase getThreadStatsUseCase,
      @required String threadId,
      @required ThreadType threadType})
      : _getThreadStatsUseCase = getThreadStatsUseCase,
        _threadId = threadId,
        _threadType = threadType,
        super(ThreadStatsInitial());

  String get threadId => _threadId;
  ThreadType get threadType => _threadType;

  Future getStats() async {
    if (state is ThreadStatsLoading) return;
    emit(ThreadStatsLoading());
    try {
      final ThreadStatsEntity threadStatsEntity =
          await _getThreadStatsUseCase.call(GetThreadStatsUseCaseParams(
              threadId: threadId, threadType: threadType));
      if (threadStatsEntity != null) {
        emit(ThreadStatsLoadSuccess(
            threadStatsUIModel: threadStatsEntity.toUIModel));
      } else
        emit(ThreadStatsLoadEmpty(message: 'Thread stats not available.'));
    } catch (e) {
      log('Thread stats load error: ', error: e);
      emit(ThreadStatsLoadError(
          message:
              'Unable to load stats. Make sure you are connected to the Internet.'));
    }
  }

  Future refreshStats() async {
    if (state is ThreadStatsLoading) return;
    try {
      final ThreadStatsEntity threadStatsEntity =
          await _getThreadStatsUseCase.call(GetThreadStatsUseCaseParams(
              threadId: threadId, threadType: threadType));
      if (threadStatsEntity != null) {
        emit(ThreadStatsLoadSuccess(
            threadStatsUIModel: threadStatsEntity.toUIModel));
      }
    } catch (e) {
      log('Thread stats load error: ', error: e);
      emit(ThreadStatsLoadError(
          message:
              'Unable to load stats. Make sure you are connected to the Internet.'));
    }
  }
}
