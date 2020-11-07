import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_daily_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_monthly_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_weekly_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_yearly_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';

part 'horoscope_event.dart';
part 'horoscope_state.dart';

class HoroscopeBloc extends Bloc<HoroscopeEvent, HoroscopeState> {
  final UseCase _getDailyHoroscopeUseCase;
  final UseCase _getWeeklyHoroscopeUseCase;
  final UseCase _getMonthlyHoroscopeUseCase;
  final UseCase _getYearlyHoroscopeUseCase;
  final HoroscopeType _type;
  HoroscopeBloc({
    @required UseCase getDailyHoroscopeUseCase,
    @required UseCase getWeeklyHoroscopeUseCase,
    @required UseCase getMonthlyHoroscopeUseCase,
    @required UseCase getYearlyHoroscopeUseCase,
    @required HoroscopeType type,
  })  : _getDailyHoroscopeUseCase = getDailyHoroscopeUseCase,
        _getWeeklyHoroscopeUseCase = getWeeklyHoroscopeUseCase,
        _getMonthlyHoroscopeUseCase = getMonthlyHoroscopeUseCase,
        _getYearlyHoroscopeUseCase = getYearlyHoroscopeUseCase,
        _type = type,
        super(HoroscopeInitialState());

  HoroscopeType get type => _type;

  @override
  Stream<HoroscopeState> mapEventToState(
    HoroscopeEvent event,
  ) async* {
    if (event is GetHoroscopeEvent) {
      yield* mapGetHoroscopeEventToState(event);
    } else if (event is RefreshHoroscopeEvent) {
      yield* mapRefreshHoroscopeEventToState(event);
    }
  }

  Stream<HoroscopeState> mapGetHoroscopeEventToState(
    GetHoroscopeEvent event,
  ) async* {
    if (state is HoroscopeLoadingState) return;
    yield HoroscopeLoadingState();
    try {
      HoroscopeEntity horoscope;
      switch (type) {
        case HoroscopeType.DAILY:
          horoscope = await _getDailyHoroscopeUseCase.call(
            GetDailyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
        case HoroscopeType.WEEKLY:
          horoscope = await _getWeeklyHoroscopeUseCase.call(
            GetWeeklyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
        case HoroscopeType.MONTHLY:
          horoscope = await _getMonthlyHoroscopeUseCase.call(
            GetMonthlyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
        case HoroscopeType.YEARLY:
          horoscope = await _getYearlyHoroscopeUseCase.call(
            GetYearlyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
      }

      if (horoscope == null) {
        yield HoroscopeEmptyState(message: 'Horoscope data not available.');
      } else {
        yield HoroscopeLoadSuccessState(horoscope: horoscope.toUIModel);
      }
    } catch (e) {
      log('Latest horoscope load error: ', error: e);
      yield HoroscopeLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.');
    }
  }

  Stream<HoroscopeState> mapRefreshHoroscopeEventToState(
    RefreshHoroscopeEvent event,
  ) async* {
    try {
      HoroscopeEntity horoscope;
      switch (type) {
        case HoroscopeType.DAILY:
          horoscope = await _getDailyHoroscopeUseCase.call(
            GetDailyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
        case HoroscopeType.WEEKLY:
          horoscope = await _getWeeklyHoroscopeUseCase.call(
            GetWeeklyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
        case HoroscopeType.MONTHLY:
          horoscope = await _getMonthlyHoroscopeUseCase.call(
            GetMonthlyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
        case HoroscopeType.YEARLY:
          horoscope = await _getYearlyHoroscopeUseCase.call(
            GetYearlyHoroscopeUseCaseParams(
              language: event.language,
            ),
          );
          break;
      }

      if (horoscope != null) {
        yield HoroscopeLoadSuccessState(horoscope: horoscope.toUIModel);
      } else
        yield HoroscopeEmptyState(message: 'Horoscope data not available.');
    } catch (e) {
      log('Refresh horoscope refresh error: ', error: e);
      yield HoroscopeErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to Internet.');
    }
  }
}
