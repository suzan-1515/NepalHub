import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetRelatedNewsUseCase
    implements UseCase<List<NewsFeedEntity>, GetRelatedNewsUseCaseParams> {
  final Repository _repository;

  GetRelatedNewsUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetRelatedNewsUseCaseParams params) {
    try {
      return this._repository.getRelatedNews(params.feed);
    } catch (e) {
      log('GetRelatedNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetRelatedNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  GetRelatedNewsUseCaseParams({this.feed});

  @override
  List<Object> get props => [feed];
}
