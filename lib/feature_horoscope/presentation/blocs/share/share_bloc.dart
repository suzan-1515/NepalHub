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

  ShareBloc({
    @required UseCase shareHoroscopeUseCase,
  })  : _shareHoroscopeUseCase = shareHoroscopeUseCase,
        super(ShareInitial());

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    if (state is ShareInProgress) return;
    if (event is Share) {
      yield ShareInProgress();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _shareHoroscopeUseCase.call(
                ShareHoroscopeUseCaseParams(horoscopeEntity: event.horoscope));
        if (horoscopeEntity != null)
          yield ShareSuccess(horoscope: horoscopeEntity);
        else
          yield ShareError(message: 'Unable to share.');
      } catch (e) {
        log('Horoscope share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
