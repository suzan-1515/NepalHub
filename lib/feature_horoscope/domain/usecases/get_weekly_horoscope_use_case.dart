import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class GetWeeklyHoroscopeUseCase
    implements UseCase<HoroscopeEntity, GetWeeklyHoroscopeUseCaseParams> {
  final Repository _repository;

  GetWeeklyHoroscopeUseCase(this._repository);

  @override
  Future<HoroscopeEntity> call(GetWeeklyHoroscopeUseCaseParams params) {
    try {
      return this._repository.getWeekly(language: params.language);
    } catch (e) {
      log('GetWeeklyHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetWeeklyHoroscopeUseCaseParams extends Equatable {
  final Language language;

  GetWeeklyHoroscopeUseCaseParams({
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
