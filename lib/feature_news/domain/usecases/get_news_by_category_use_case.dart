import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsByCategoryUseCase
    implements UseCase<List<NewsFeedEntity>, GetNewsByCategoryUseCaseParams> {
  final Repository _repository;

  GetNewsByCategoryUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetNewsByCategoryUseCaseParams params) {
    try {
      return this._repository.getNewsByCategory(
            params.category,
            source: params.source,
            sortBy: params.sortBy,
            page: params.page,
          );
    } catch (e) {
      log('GetNewsByCategoryUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsByCategoryUseCaseParams extends Equatable {
  final NewsCategoryEntity category;
  final NewsSourceEntity source;
  final SortBy sortBy;
  final int page;
  final Language language;

  GetNewsByCategoryUseCaseParams(
      {@required this.category,
      this.source,
      this.sortBy,
      this.page,
      this.language});

  @override
  List<Object> get props => [category, source, sortBy, page];
}
