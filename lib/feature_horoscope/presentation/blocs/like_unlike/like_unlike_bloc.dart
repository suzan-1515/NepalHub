import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/like_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/unlike_horoscope_use_case.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeHoroscopeUseCase;
  final UseCase _unLikeHoroscopeUseCase;

  LikeUnlikeBloc({
    @required UseCase likeHoroscopeUseCase,
    @required UseCase unLikeHoroscopeUseCase,
  })  : _likeHoroscopeUseCase = likeHoroscopeUseCase,
        _unLikeHoroscopeUseCase = unLikeHoroscopeUseCase,
        super(InitialState());

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    if (state is InProgressState) return;
    if (event is LikeEvent) {
      yield InProgressState();
      try {
        final HoroscopeEntity horoscopeEntity = await _likeHoroscopeUseCase
            .call(LikeHoroscopeUseCaseParams(horoscopeEntity: event.horoscope));
        if (horoscopeEntity != null)
          yield LikedState(horoscope: horoscopeEntity);
        else
          yield ErrorState(message: 'Unable to like.');
      } catch (e) {
        log('Horoscope like error.', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      yield InProgressState();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _unLikeHoroscopeUseCase.call(
                UnlikeHoroscopeUseCaseParams(horoscopeEntity: event.horoscope));
        if (horoscopeEntity != null)
          yield UnlikedState(horoscope: event.horoscope);
        else
          yield ErrorState(message: 'Unable to unlike.');
      } catch (e) {
        log('Horoscope unlike error.', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
