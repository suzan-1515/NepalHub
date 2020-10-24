import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/like_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/unlike_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeForexUseCase;
  final UseCase _unLikeForexUseCase;
  final ForexUIModel _forexUIModel;

  LikeUnlikeBloc({
    @required UseCase likeForexUseCase,
    @required UseCase unLikeForexUseCase,
    @required ForexUIModel forexUIModel,
  })  : _likeForexUseCase = likeForexUseCase,
        _unLikeForexUseCase = unLikeForexUseCase,
        _forexUIModel = forexUIModel,
        super(InitialState());

  ForexUIModel get forexUIModel => _forexUIModel;

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is InProgressState) return;
    if (event is LikeEvent) {
      yield InProgressState();
      try {
        final ForexEntity forexEntity = await _likeForexUseCase.call(
            LikeForexUseCaseParams(forexEntity: forexUIModel.forexEntity));
        if (forexEntity != null) forexUIModel.forexEntity = forexEntity;
        yield LikedState(message: 'Forex liked successfully.');
      } catch (e) {
        log('Forex like error.', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      yield InProgressState();
      try {
        final ForexEntity forexEntity = await _unLikeForexUseCase.call(
            UnlikeForexUseCaseParams(forexEntity: forexUIModel.forexEntity));
        if (forexEntity != null) forexUIModel.forexEntity = forexEntity;
        yield UnlikedState(message: 'Forex unliked successfully.');
      } catch (e) {
        log('Forex unlike error.', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
