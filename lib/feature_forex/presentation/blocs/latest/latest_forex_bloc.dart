import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/get_latest_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/extensions/forex_extensions.dart';

part 'latest_forex_event.dart';
part 'latest_forex_state.dart';

class ForexBloc extends Bloc<ForexEvent, ForexState> {
  final UseCase _getLatestForexUseCase;
  ForexBloc({@required UseCase getLatestForexUseCase})
      : _getLatestForexUseCase = getLatestForexUseCase,
        super(ForexInitialState());

  @override
  Stream<ForexState> mapEventToState(
    ForexEvent event,
  ) async* {
    if (event is GetLatestForexEvent) {
      yield* mapGetLatestForexEventToState(event);
    } else if (event is RefreshLatestForexEvent) {
      yield* mapRefreshLatestForexEventToState(event);
    }
  }

  Stream<ForexState> mapGetLatestForexEventToState(
    GetLatestForexEvent event,
  ) async* {
    if (state is ForexLoadingState) return;
    yield ForexLoadingState();
    try {
      final List<ForexEntity> forexList = await _getLatestForexUseCase.call(
        GetLatestForexUseCaseParams(
          language: event.language,
        ),
      );

      if (forexList == null || forexList.isEmpty) {
        yield ForexEmptyState(message: 'Forex data not available.');
      } else {
        final defaultForex = (event.defaultCurrencyCode == null)
            ? forexList.first
            : forexList.firstWhere((element) =>
                element.currency.code == event.defaultCurrencyCode);
        yield ForexLoadSuccessState(
            forexList: forexList.toUIModels,
            defaultForex: defaultForex.toUIModel);
      }
    } catch (e) {
      log('Latest forex load error: ', error: e);
      yield ForexLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.');
    }
  }

  Stream<ForexState> mapRefreshLatestForexEventToState(
    RefreshLatestForexEvent event,
  ) async* {
    try {
      final List<ForexEntity> forexList = await _getLatestForexUseCase.call(
        GetLatestForexUseCaseParams(
          language: event.language,
        ),
      );

      if (forexList != null && forexList.isNotEmpty) {
        final defaultForex = (event.defaultCurrencyCode == null)
            ? forexList.first
            : forexList.firstWhere((element) =>
                element.currency.code == event.defaultCurrencyCode);
        yield ForexLoadSuccessState(
            forexList: forexList.toUIModels,
            defaultForex: defaultForex.toUIModel);
      } else
        yield ForexErrorState(message: 'Unable to refresh data.');
    } catch (e) {
      log('Latest forex refresh error: ', error: e);
      yield ForexErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to Internet.');
    }
  }
}
