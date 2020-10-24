import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/dislike_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/undislike_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeForexUseCase;
  final UseCase _undislikeForexUseCase;
  final ForexUIModel _forexUIModel;

  DislikeBloc({
    @required UseCase dislikeForexUseCase,
    @required UseCase undislikeForexUseCase,
    @required ForexUIModel forexUIModel,
  })  : _dislikeForexUseCase = dislikeForexUseCase,
        _undislikeForexUseCase = undislikeForexUseCase,
        _forexUIModel = forexUIModel,
        super(DislikeInitial());

  ForexUIModel get forexUIModel => _forexUIModel;

  @override
  Stream<DislikeState> mapEventToState(
    DislikeUndislikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is DislikeInProgress) return;
    if (event is DislikeEvent) {
      yield DislikeInProgress();
      try {
        final ForexEntity forexEntity = await _dislikeForexUseCase.call(
            DislikeForexUseCaseParams(forexEntity: forexUIModel.forexEntity));
        if (forexEntity != null) forexUIModel.forexEntity = forexEntity;
        yield DislikeSuccess(message: 'Feed disliked successfully.');
      } catch (e) {
        log('Forex dislike error.', error: e);
        yield DislikeError(message: 'Unable to like.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        final ForexEntity forexEntity = await _undislikeForexUseCase.call(
            UndislikeForexUseCaseParams(forexEntity: forexUIModel.forexEntity));
        if (forexEntity != null) forexUIModel.forexEntity = forexEntity;
        yield UndislikeSuccess(message: 'News forex undisliked successfully.');
      } catch (e) {
        log('Forex undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
