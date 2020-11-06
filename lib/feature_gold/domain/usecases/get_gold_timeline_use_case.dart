import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class GetGoldSilverTimelineUseCase
    implements
        UseCase<List<GoldSilverEntity>, GetGoldSilverTimelineUseCaseParams> {
  final Repository _repository;

  GetGoldSilverTimelineUseCase(this._repository);

  @override
  Future<List<GoldSilverEntity>> call(
      GetGoldSilverTimelineUseCaseParams params) {
    try {
      return this._repository.getGoldSilverTimeline(
          categoryId: params.categoryId,
          unit: params.unit,
          numOfDays: params.numOfDays,
          language: params.language);
    } catch (e) {
      log('GetGoldSilverTimelineUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetGoldSilverTimelineUseCaseParams extends Equatable {
  final Language language;
  final String categoryId;
  final String unit;
  final int numOfDays;

  GetGoldSilverTimelineUseCaseParams({
    @required this.categoryId,
    @required this.unit,
    this.numOfDays,
    @required this.language,
  });

  @override
  List<Object> get props => [language, categoryId, numOfDays, unit];
}
