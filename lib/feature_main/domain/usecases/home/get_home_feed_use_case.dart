import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/domain/repositories/home/repository.dart';

class GetHomeFeedUseCase
    implements UseCase<HomeEntity, GetHomeFeedUseCaseParams> {
  final Repository _repository;

  GetHomeFeedUseCase(this._repository);

  @override
  Future<HomeEntity> call(GetHomeFeedUseCaseParams params) {
    try {
      return this._repository.getHomeFeed(language: params.language);
    } catch (e) {
      log('GetHomeFeedUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetHomeFeedUseCaseParams extends Equatable {
  final Language language;

  GetHomeFeedUseCaseParams({@required this.language});
  @override
  List<Object> get props => [language];
}
