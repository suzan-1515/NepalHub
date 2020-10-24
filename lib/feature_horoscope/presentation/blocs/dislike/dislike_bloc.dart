import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/dislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/undislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeHoroscopeUseCase;
  final UseCase _undislikeHoroscopeUseCase;
  final HoroscopeUIModel _horoscopeUIModel;

  DislikeBloc({
    @required UseCase dislikeHoroscopeUseCase,
    @required UseCase undislikeHoroscopeUseCase,
    @required HoroscopeUIModel horoscopeUIModel,
  })  : _dislikeHoroscopeUseCase = dislikeHoroscopeUseCase,
        _undislikeHoroscopeUseCase = undislikeHoroscopeUseCase,
        _horoscopeUIModel = horoscopeUIModel,
        super(DislikeInitial());

  HoroscopeUIModel get horoscopeUIModel => _horoscopeUIModel;

  @override
  Stream<DislikeState> mapEventToState(
    DislikeUndislikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is DislikeInProgress) return;
    if (event is DislikeEvent) {
      yield DislikeInProgress();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _dislikeHoroscopeUseCase.call(DislikeHoroscopeUseCaseParams(
                horoscopeEntity: horoscopeUIModel.horoscopeEntity));
        if (horoscopeEntity != null)
          horoscopeUIModel.horoscopeEntity = horoscopeEntity;
        yield DislikeSuccess(message: 'Horoscope disliked successfully.');
      } catch (e) {
        log('Horoscope dislike error.', error: e);
        yield DislikeError(message: 'Unable to like.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        final HoroscopeEntity horoscopeEntity = await _undislikeHoroscopeUseCase
            .call(UndislikeHoroscopeUseCaseParams(
                horoscopeEntity: horoscopeUIModel.horoscopeEntity));
        if (horoscopeEntity != null)
          horoscopeUIModel.horoscopeEntity = horoscopeEntity;
        yield UndislikeSuccess(message: 'Horoscope undisliked successfully.');
      } catch (e) {
        log('Horoscope undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
