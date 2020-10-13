import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/get_currencies_use_case.dart';

part 'forex_currency_event.dart';
part 'forex_currency_state.dart';

class ForexCurrencyBloc extends Bloc<ForexCurrencyEvent, ForexCurrencyState> {
  final GetForexCurrenciesUseCase _getForexCurrenciesUseCase;
  ForexCurrencyBloc(
      {@required GetForexCurrenciesUseCase getForexCurrenciesUseCase})
      : _getForexCurrenciesUseCase = getForexCurrenciesUseCase,
        super(ForexCurrencyInitialState());

  @override
  Stream<ForexCurrencyState> mapEventToState(
    ForexCurrencyEvent event,
  ) async* {
    if (event is GetForexCurrencies) {
      if (state is ForexCurrencyLoadingState) return;
      yield ForexCurrencyLoadingState();
      try {
        final List<CurrencyEntity> currencies =
            await _getForexCurrenciesUseCase.call(
          GetForexCurrenciesUseCaseParams(language: event.language),
        );
        if (currencies == null || currencies.isEmpty) {
          yield ForexCurrencyEmptyState(
              message: 'Forex currencies not available.');
        } else
          yield ForexCurrencyLoadSuccessState(currencies: currencies);
      } catch (e) {
        log('Forex currency load error: ', error: e);
        yield ForexCurrencyLoadErrorState(
            message:
                'Unable to load forex currencies. Make sure you are connected to Internet.');
      }
    }
  }
}
