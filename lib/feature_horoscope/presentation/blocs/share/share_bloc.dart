import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/share_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final UseCase _shareHoroscopeUseCase;
  final HoroscopeUIModel _horoscopeUIModel;

  ShareBloc({
    @required UseCase shareHoroscopeUseCase,
    @required HoroscopeUIModel horoscopeUIModel,
  })  : _shareHoroscopeUseCase = shareHoroscopeUseCase,
        _horoscopeUIModel = horoscopeUIModel,
        super(ShareInitial());

  HoroscopeUIModel get horoscopeUIModel => _horoscopeUIModel;

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ShareInProgress) return;
    if (event is Share) {
      yield ShareInProgress();
      try {
        final HoroscopeEntity horoscopeEntity =
            await _shareHoroscopeUseCase.call(ShareHoroscopeUseCaseParams(
                horoscopeEntity: horoscopeUIModel.horoscopeEntity));
        if (horoscopeEntity != null)
          horoscopeUIModel.horoscopeEntity = horoscopeEntity;
        yield ShareSuccess(message: 'Horoscope shared successfully.');
      } catch (e) {
        log('Horoscope share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
