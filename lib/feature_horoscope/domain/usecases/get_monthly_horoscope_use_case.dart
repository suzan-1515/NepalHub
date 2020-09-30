import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class GetMonthlyHoroscopeUseCase
    implements UseCase<HoroscopeEntity, GetMonthlyHoroscopeUseCaseParams> {
  final Repository _repository;

  GetMonthlyHoroscopeUseCase(this._repository);

  @override
  Future<HoroscopeEntity> call(GetMonthlyHoroscopeUseCaseParams params) {
    try {
      return this._repository.getMonthly(language: params.language);
    } catch (e) {
      log('GetMonthlyHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetMonthlyHoroscopeUseCaseParams extends Equatable {
  final Language language;

  GetMonthlyHoroscopeUseCaseParams({
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
