import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class UnBookmarkNewsUseCase
    implements UseCase<NewsFeedEntity, UnBookmarkNewsUseCaseParams> {
  final Repository _repository;

  UnBookmarkNewsUseCase(this._repository);

  @override
  Future<NewsFeedEntity> call(UnBookmarkNewsUseCaseParams params) {
    try {
      return this._repository.unBookmarkFeed(params.feed);
    } catch (e) {
      log('UnBookmarkNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnBookmarkNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  UnBookmarkNewsUseCaseParams({this.feed});

  @override
  List<Object> get props => [feed];
}
