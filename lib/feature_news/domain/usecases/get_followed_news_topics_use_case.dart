import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetFollowedNewsTopicsUseCase
    implements
        UseCase<List<NewsTopicEntity>, GetFollowedNewsTopicsUseCaseParams> {
  final Repository _repository;

  GetFollowedNewsTopicsUseCase(this._repository);

  @override
  Future<List<NewsTopicEntity>> call(
      GetFollowedNewsTopicsUseCaseParams params) {
    try {
      return this._repository.getTopics(language: params.language);
    } catch (e) {
      log('GetFollowedNewsTopicsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetFollowedNewsTopicsUseCaseParams extends Equatable {
  final Language language;

  GetFollowedNewsTopicsUseCaseParams({this.language});

  @override
  List<Object> get props => [language];
}
