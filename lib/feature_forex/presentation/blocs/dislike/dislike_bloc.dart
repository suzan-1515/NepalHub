import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/dislike_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/undislike_forex_use_case.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeForexUseCase;
  final UseCase _undislikeForexUseCase;
  DislikeBloc({
    @required UseCase dislikeForexUseCase,
    @required UseCase undislikeForexUseCase,
  })  : _dislikeForexUseCase = dislikeForexUseCase,
        _undislikeForexUseCase = undislikeForexUseCase,
        super(DislikeInitial());

  @override
  Stream<DislikeState> mapEventToState(
    DislikeUndislikeEvent event,
  ) async* {
    if (state is DislikeInProgress) return;
    if (event is DislikeEvent) {
      yield DislikeInProgress();
      try {
        final ForexEntity forexEntity = await _dislikeForexUseCase
            .call(DislikeForexUseCaseParams(forexEntity: event.forex));
        if (forexEntity != null)
          yield DislikeSuccess(forex: forexEntity);
        else
          yield DislikeError(message: 'Unable to dislike.');
      } catch (e) {
        log('Forex dislike error.', error: e);
        yield DislikeError(message: 'Unable to like.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        final ForexEntity forexEntity = await _undislikeForexUseCase
            .call(UndislikeForexUseCaseParams(forexEntity: event.forex));
        if (forexEntity != null)
          yield UndislikeSuccess(forex: forexEntity);
        else
          yield DislikeError(message: 'Unable to undislike.');
      } catch (e) {
        log('Forex undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
