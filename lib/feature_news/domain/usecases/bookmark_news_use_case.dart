import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class BookmarkNewsUseCase
    implements UseCase<NewsFeedEntity, BookmarkNewsUseCaseParams> {
  final Repository _repository;

  BookmarkNewsUseCase(this._repository);

  @override
  Future<NewsFeedEntity> call(BookmarkNewsUseCaseParams params) {
    try {
      return this._repository.bookmarkFeed(params.feed);
    } catch (e) {
      log('BookmarkNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class BookmarkNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  BookmarkNewsUseCaseParams({this.feed});

  @override
  List<Object> get props => [feed];
}
