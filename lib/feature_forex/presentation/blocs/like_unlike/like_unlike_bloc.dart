import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/like_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/unlike_forex_use_case.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeForexUseCase;
  final UseCase _unLikeForexUseCase;

  LikeUnlikeBloc({
    @required UseCase likeForexUseCase,
    @required UseCase unLikeForexUseCase,
  })  : _likeForexUseCase = likeForexUseCase,
        _unLikeForexUseCase = unLikeForexUseCase,
        super(InitialState());

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    if (state is InProgressState) return;
    if (event is LikeEvent) {
      yield InProgressState();
      try {
        final ForexEntity forexEntity = await _likeForexUseCase
            .call(LikeForexUseCaseParams(forexEntity: event.forex));
        if (forexEntity != null)
          yield LikedState(forex: forexEntity);
        else
          yield ErrorState(message: 'Unable to like.');
      } catch (e) {
        log('Forex like error.', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      yield InProgressState();
      try {
        final ForexEntity forexEntity = await _unLikeForexUseCase
            .call(UnlikeForexUseCaseParams(forexEntity: event.forex));
        if (forexEntity != null)
          yield UnlikedState(forex: forexEntity);
        else
          yield ErrorState(message: 'Unable to unlike.');
      } catch (e) {
        log('Forex unlike error.', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
