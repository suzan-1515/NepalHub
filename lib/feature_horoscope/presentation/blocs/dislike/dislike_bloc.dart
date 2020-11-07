import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/dislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/undislike_horoscope_use_case.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeHoroscopeUseCase;
  final UseCase _undislikeHoroscopeUseCase;

  DislikeBloc({
    @required UseCase dislikeHoroscopeUseCase,
    @required UseCase undislikeHoroscopeUseCase,
  })  : _dislikeHoroscopeUseCase = dislikeHoroscopeUseCase,
        _undislikeHoroscopeUseCase = undislikeHoroscopeUseCase,
        super(DislikeInitial());

  @override
  Stream<DislikeState> mapEventToState(
    DislikeUndislikeEvent event,
  ) async* {
    if (state is DislikeInProgress) return;
    if (event is DislikeEvent) {
      yield DislikeInProgress();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _dislikeHoroscopeUseCase.call(DislikeHoroscopeUseCaseParams(
                horoscopeEntity: event.horoscope));
        if (horoscopeEntity != null)
          yield DislikeSuccess(horoscope: event.horoscope);
        else
          yield DislikeError(message: 'Unable to dislike.');
      } catch (e) {
        log('Horoscope dislike error.', error: e);
        yield DislikeError(message: 'Unable to like.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        final HoroscopeEntity horoscopeEntity = await _undislikeHoroscopeUseCase
            .call(UndislikeHoroscopeUseCaseParams(
                horoscopeEntity: event.horoscope));
        if (horoscopeEntity != null)
          yield UndislikeSuccess(horoscope: event.horoscope);
        else
          yield DislikeError(message: 'Unable to undislike.');
      } catch (e) {
        log('Horoscope undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
