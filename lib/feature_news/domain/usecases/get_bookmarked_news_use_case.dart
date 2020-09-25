import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetBookmarkedNewsUseCase
    implements UseCase<List<NewsFeedEntity>, GetBookmarkedNewsUseCaseParams> {
  final Repository _repository;

  GetBookmarkedNewsUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetBookmarkedNewsUseCaseParams params) {
    try {
      return this._repository.getBookmarkedNews(page: params.page);
    } catch (e) {
      log('GetBookmarkedNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetBookmarkedNewsUseCaseParams extends Equatable {
  final int page;

  GetBookmarkedNewsUseCaseParams({this.page});

  @override
  List<Object> get props => [page];
}
