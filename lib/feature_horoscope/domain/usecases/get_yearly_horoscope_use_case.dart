import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class GetYearlyHoroscopeUseCase
    implements UseCase<HoroscopeEntity, GetYearlyHoroscopeUseCaseParams> {
  final Repository _repository;

  GetYearlyHoroscopeUseCase(this._repository);

  @override
  Future<HoroscopeEntity> call(GetYearlyHoroscopeUseCaseParams params) {
    try {
      return this._repository.getYearly(language: params.language);
    } catch (e) {
      log('GetYearlyHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetYearlyHoroscopeUseCaseParams extends Equatable {
  final Language language;

  GetYearlyHoroscopeUseCaseParams({
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
