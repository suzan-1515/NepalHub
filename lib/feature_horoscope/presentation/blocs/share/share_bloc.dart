import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/share_horoscope_use_case.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final UseCase _shareHoroscopeUseCase;
  final HoroscopeEntity _horoscopeEntity;

  ShareBloc({
    @required UseCase shareNewsFeedUseCase,
    @required HoroscopeEntity horoscopeEntity,
  })  : _shareHoroscopeUseCase = shareNewsFeedUseCase,
        _horoscopeEntity = horoscopeEntity,
        super(ShareInitial());

  HoroscopeEntity get horoscopeEntity => _horoscopeEntity;

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ShareInProgress) return;
    if (event is Share) {
      yield ShareInProgress();
      try {
        await _shareHoroscopeUseCase.call(
            ShareHoroscopeUseCaseParams(horoscopeEntity: horoscopeEntity));
        yield ShareSuccess(message: 'Horoscope shared successfully.');
      } catch (e) {
        log('Horoscope share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
