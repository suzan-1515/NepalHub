import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/view_horoscope_use_case.dart';

part 'view_event.dart';
part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final UseCase _viewNewsFeedUseCase;
  final HoroscopeEntity _horoscopeEntity;

  ViewBloc({
    @required UseCase viewNewsFeedUseCase,
    @required HoroscopeEntity horoscopeEntity,
  })  : _viewNewsFeedUseCase = viewNewsFeedUseCase,
        _horoscopeEntity = horoscopeEntity,
        super(ViewInitial());

  HoroscopeEntity get horoscopeEntity => _horoscopeEntity;

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    if (state is ViewInProgress) return;
    if (event is View) {
      yield ViewInProgress();
      try {
        await _viewNewsFeedUseCase
            .call(ViewHoroscopeUseCaseParams(horoscopeEntity: horoscopeEntity));
        yield ViewSuccess(message: 'Horoscope viewd successfully.');
      } catch (e) {
        log('Horoscope view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
