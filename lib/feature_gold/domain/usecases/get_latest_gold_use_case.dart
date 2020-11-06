import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class GetLatestGoldSilverUseCase
    implements
        UseCase<List<GoldSilverEntity>, GetLatestGoldSilverUseCaseParams> {
  final Repository _repository;

  GetLatestGoldSilverUseCase(this._repository);

  @override
  Future<List<GoldSilverEntity>> call(GetLatestGoldSilverUseCaseParams params) {
    try {
      return this._repository.getLatestGoldSilver(language: params.language);
    } catch (e) {
      log('GetLatestGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetLatestGoldSilverUseCaseParams extends Equatable {
  final Language language;

  GetLatestGoldSilverUseCaseParams({@required this.language});

  @override
  List<Object> get props => [language];
}
