import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeGoldSilverUseCase;
  final UseCase _undislikeGoldSilverUseCase;

  DislikeBloc({
    @required UseCase dislikeGoldSilverUseCase,
    @required UseCase undislikeGoldSilverUseCase,
  })  : _dislikeGoldSilverUseCase = dislikeGoldSilverUseCase,
        _undislikeGoldSilverUseCase = undislikeGoldSilverUseCase,
        super(DislikeInitial());

  @override
  Stream<DislikeState> mapEventToState(
    DislikeUndislikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is DislikeInProgress) return;
    if (event is DislikeEvent) {
      yield DislikeInProgress();
      try {
        final GoldSilverEntity goldSilverEntity =
            await _dislikeGoldSilverUseCase.call(DislikeGoldSilverUseCaseParams(
                goldSilverEntity: event.goldSilver));
        if (goldSilverEntity != null)
          yield DislikeSuccess(goldSilver: goldSilverEntity);
        else
          yield DislikeError(message: 'Unable to dislike.');
      } catch (e) {
        log('GoldSilver dislike error.', error: e);
        yield DislikeError(message: 'Unable to like.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        final GoldSilverEntity goldSilverEntity =
            await _undislikeGoldSilverUseCase.call(
                UndislikeGoldSilverUseCaseParams(
                    goldSilverEntity: event.goldSilver));
        if (goldSilverEntity != null)
          yield UndislikeSuccess(goldSilver: goldSilverEntity);
        else
          yield DislikeError(message: 'Unable to undislike.');
      } catch (e) {
        log('GoldSilver undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
