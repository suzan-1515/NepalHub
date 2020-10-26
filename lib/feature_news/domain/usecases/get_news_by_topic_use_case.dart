import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsByTopicUseCase
    implements UseCase<List<NewsFeedEntity>, GetNewsByTopicUseCaseParams> {
  final Repository _repository;

  GetNewsByTopicUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetNewsByTopicUseCaseParams params) {
    try {
      return this._repository.getNewsByTopic(params.topic,
          source: params.source,
          sortBy: params.sortBy,
          page: params.page,
          language: params.language);
    } catch (e) {
      log('GetNewsByTopicUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsByTopicUseCaseParams extends Equatable {
  final NewsTopicEntity topic;
  final NewsSourceEntity source;
  final SortBy sortBy;
  final int page;
  final Language language;

  GetNewsByTopicUseCaseParams(
      {this.topic, this.source, this.sortBy, this.page, this.language});

  @override
  List<Object> get props => [topic, source, sortBy, page, language];
}
