import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class GetForexCurrenciesUseCase
    implements UseCase<List<CurrencyEntity>, GetForexCurrenciesUseCaseParams> {
  final Repository _repository;

  GetForexCurrenciesUseCase(this._repository);

  @override
  Future<List<CurrencyEntity>> call(GetForexCurrenciesUseCaseParams params) {
    try {
      return this._repository.getCurrencies(language: params.language);
    } catch (e) {
      log('GetForexCurrenciesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetForexCurrenciesUseCaseParams extends Equatable {
  final Language language;

  GetForexCurrenciesUseCaseParams({
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
