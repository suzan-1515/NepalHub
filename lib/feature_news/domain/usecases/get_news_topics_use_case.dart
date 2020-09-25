import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsTopicsUseCase
    implements UseCase<List<NewsTopicEntity>, GetNewsTopicsUseCaseParams> {
  final Repository _repository;

  GetNewsTopicsUseCase(this._repository);

  @override
  Future<List<NewsTopicEntity>> call(GetNewsTopicsUseCaseParams params) {
    try {
      return this._repository.getTopics(language: params.language);
    } catch (e) {
      log('GetNewsTopicsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsTopicsUseCaseParams extends Equatable {
  final Language language;

  GetNewsTopicsUseCaseParams({this.language});

  @override
  List<Object> get props => [language];
}
