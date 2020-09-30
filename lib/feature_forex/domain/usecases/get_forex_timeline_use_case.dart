import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class GetForexTimelineUseCase
    implements UseCase<List<ForexEntity>, GetForexTimelineUseCaseParams> {
  final Repository _repository;

  GetForexTimelineUseCase(this._repository);

  @override
  Future<List<ForexEntity>> call(GetForexTimelineUseCaseParams params) {
    try {
      return this._repository.getForexTimeline(
          currencyId: params.currencyId,
          numOfDays: params.numOfDays,
          language: params.language);
    } catch (e) {
      log('GetForexTimelineUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetForexTimelineUseCaseParams extends Equatable {
  final Language language;
  final String currencyId;
  final int numOfDays;

  GetForexTimelineUseCaseParams({
    @required this.currencyId,
    this.numOfDays,
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
