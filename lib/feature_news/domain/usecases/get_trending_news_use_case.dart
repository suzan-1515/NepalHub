import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetTrendingNewsUseCase
    implements UseCase<List<NewsFeedEntity>, GetTrendingNewsUseCaseParams> {
  final Repository _repository;

  GetTrendingNewsUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetTrendingNewsUseCaseParams params) {
    try {
      return this._repository.getTrendingNews(
          sortBy: params.sortBy,
          page: params.page,
          limit: params.limit,
          language: params.language);
    } catch (e) {
      log('GetTrendingNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetTrendingNewsUseCaseParams extends Equatable {
  final SortBy sortBy;
  final int page;
  final int limit;
  final Language language;

  GetTrendingNewsUseCaseParams(
      {this.sortBy, this.page, this.limit, this.language});

  @override
  List<Object> get props => [sortBy, page, limit, language];
}
