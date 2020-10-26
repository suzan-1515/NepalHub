import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetFollowedNewsSourcesUseCase
    implements
        UseCase<List<NewsSourceEntity>, GetFollowedNewsSourcesUseCaseParams> {
  final Repository _repository;

  GetFollowedNewsSourcesUseCase(this._repository);

  @override
  Future<List<NewsSourceEntity>> call(
      GetFollowedNewsSourcesUseCaseParams params) {
    try {
      return this._repository.getSources(language: params.language);
    } catch (e) {
      log('GetFollowedNewsSourcesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetFollowedNewsSourcesUseCaseParams extends Equatable {
  final Language language;

  GetFollowedNewsSourcesUseCaseParams({this.language});

  @override
  List<Object> get props => [language];
}
