import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/like_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/unlike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeHoroscopeUseCase;
  final UseCase _unLikeHoroscopeUseCase;
  final HoroscopeUIModel _horoscopeUIModel;

  LikeUnlikeBloc({
    @required UseCase likeHoroscopeUseCase,
    @required UseCase unLikeHoroscopeUseCase,
    @required HoroscopeUIModel horoscopeUIModel,
  })  : _likeHoroscopeUseCase = likeHoroscopeUseCase,
        _unLikeHoroscopeUseCase = unLikeHoroscopeUseCase,
        _horoscopeUIModel = horoscopeUIModel,
        super(InitialState());

  HoroscopeUIModel get horoscopeUIModel => _horoscopeUIModel;

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is InProgressState) return;
    if (event is LikeEvent) {
      yield InProgressState();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _likeHoroscopeUseCase.call(LikeHoroscopeUseCaseParams(
                horoscopeEntity: horoscopeUIModel.horoscopeEntity));
        if (horoscopeEntity != null)
          horoscopeUIModel.horoscopeEntity = horoscopeEntity;
        yield LikedState(message: 'Horoscope liked successfully.');
      } catch (e) {
        log('Horoscope like error.', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      yield InProgressState();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _unLikeHoroscopeUseCase.call(UnlikeHoroscopeUseCaseParams(
                horoscopeEntity: horoscopeUIModel.horoscopeEntity));
        if (horoscopeEntity != null)
          horoscopeUIModel.horoscopeEntity = horoscopeEntity;
        yield UnlikedState(message: 'Horoscope unliked successfully.');
      } catch (e) {
        log('Horoscope unlike error.', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
