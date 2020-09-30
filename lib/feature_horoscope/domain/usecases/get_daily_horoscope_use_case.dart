import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class GetDailyHoroscopeUseCase
    implements UseCase<HoroscopeEntity, GetDailyHoroscopeUseCaseParams> {
  final Repository _repository;

  GetDailyHoroscopeUseCase(this._repository);

  @override
  Future<HoroscopeEntity> call(GetDailyHoroscopeUseCaseParams params) {
    try {
      return this._repository.getDaily(language: params.language);
    } catch (e) {
      log('GetDailyHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetDailyHoroscopeUseCaseParams extends Equatable {
  final Language language;

  GetDailyHoroscopeUseCaseParams({
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
