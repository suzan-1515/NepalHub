import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeGoldSilverUseCase;
  final UseCase _unLikeGoldSilverUseCase;

  LikeUnlikeBloc({
    @required UseCase likeGoldSilverUseCase,
    @required UseCase unLikeGoldSilverUseCase,
  })  : _likeGoldSilverUseCase = likeGoldSilverUseCase,
        _unLikeGoldSilverUseCase = unLikeGoldSilverUseCase,
        super(InitialState());

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    if (event is LikeEvent) {
      yield* _mapLikeEventToState(event);
    } else if (event is UnlikeEvent) {
      yield* _mapUnLikeEventToState(event);
    }
  }

  Stream<LikeUnlikeState> _mapLikeEventToState(LikeEvent event) async* {
    if (state is InProgressState) return;
    yield InProgressState();
    try {
      final GoldSilverEntity goldSilverEntity =
          await _likeGoldSilverUseCase.call(
              LikeGoldSilverUseCaseParams(goldSilverEntity: event.goldSilver));
      if (goldSilverEntity != null)
        yield LikedState(goldSilver: goldSilverEntity);
      else
        yield ErrorState(message: 'Unable to like.');
    } catch (e) {
      log('GoldSilver like error.', error: e);
      yield ErrorState(message: 'Unable to like.');
    }
  }

  Stream<LikeUnlikeState> _mapUnLikeEventToState(UnlikeEvent event) async* {
    if (state is InProgressState) return;
    yield InProgressState();
    try {
      final GoldSilverEntity goldSilverEntity =
          await _unLikeGoldSilverUseCase.call(UnlikeGoldSilverUseCaseParams(
              goldSilverEntity: event.goldSilver));
      if (goldSilverEntity != null)
        yield UnlikedState(goldSilver: goldSilverEntity);
      else
        yield ErrorState(message: 'Unable to unlike.');
    } catch (e) {
      log('GoldSilver unlike error.', error: e);
      yield ErrorState(message: 'Unable to unlike.');
    }
  }
}
