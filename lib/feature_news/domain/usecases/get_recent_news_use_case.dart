import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetRecentNewsUseCase
    implements UseCase<List<NewsFeedEntity>, GetRecentNewsUseCaseParams> {
  final Repository _repository;

  GetRecentNewsUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetRecentNewsUseCaseParams params) {
    try {
      return this._repository.getRecentNews(
          sortBy: params.sortBy, page: params.page, language: params.language);
    } catch (e) {
      log('GetRecentNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetRecentNewsUseCaseParams extends Equatable {
  final Language language;
  final SortBy sortBy;
  final int page;

  GetRecentNewsUseCaseParams({this.language, this.sortBy, this.page});

  @override
  List<Object> get props => [language, sortBy, page];
}
