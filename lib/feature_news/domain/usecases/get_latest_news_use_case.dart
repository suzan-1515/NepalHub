import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetLatestNewsUseCase
    implements UseCase<List<NewsFeedEntity>, GetLatestNewsUseCaseParams> {
  final Repository _repository;

  GetLatestNewsUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetLatestNewsUseCaseParams params) {
    try {
      return this._repository.getLatestNews(
          sortBy: params.sortBy, page: params.page, language: params.language);
    } catch (e) {
      log('GetLatestNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetLatestNewsUseCaseParams extends Equatable {
  final Language language;
  final SortBy sortBy;
  final int page;

  GetLatestNewsUseCaseParams({this.language, this.sortBy, this.page});

  @override
  List<Object> get props => [language, sortBy, page];
}
