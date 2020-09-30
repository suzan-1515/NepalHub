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
  final ForexEntity _forexEntity;

  LikeUnlikeBloc({
    @required UseCase likeNewsFeedUseCase,
    @required UseCase unLikeNewsFeedUseCase,
    @required ForexEntity forexEntity,
  })  : _likeForexUseCase = likeNewsFeedUseCase,
        _unLikeForexUseCase = unLikeNewsFeedUseCase,
        _forexEntity = forexEntity,
        super(InitialState());

  ForexEntity get forexEntity => _forexEntity;

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is InProgressState) return;
    if (event is LikeEvent) {
      yield InProgressState();
      try {
        await _likeForexUseCase
            .call(LikeForexUseCaseParams(forexEntity: forexEntity));
        yield LikedState(message: 'Forex liked successfully.');
      } catch (e) {
        log('Forex like error.', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      yield InProgressState();
      try {
        await _unLikeForexUseCase
            .call(UnlikeForexUseCaseParams(forexEntity: forexEntity));
        yield UnlikedState(message: 'Forex unliked successfully.');
      } catch (e) {
        log('Forex unlike error.', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
