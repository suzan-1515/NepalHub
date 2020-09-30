import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class GetLatestForexUseCase
    implements UseCase<List<ForexEntity>, GetLatestForexUseCaseParams> {
  final Repository _repository;

  GetLatestForexUseCase(this._repository);

  @override
  Future<List<ForexEntity>> call(GetLatestForexUseCaseParams params) {
    try {
      return this._repository.getLatestForex(language: params.language);
    } catch (e) {
      log('GetLatestForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetLatestForexUseCaseParams extends Equatable {
  final Language language;

  GetLatestForexUseCaseParams({@required this.language});

  @override
  List<Object> get props => [language];
}
