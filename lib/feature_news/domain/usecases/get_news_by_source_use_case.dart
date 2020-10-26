import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsBySourceUseCase
    implements UseCase<List<NewsFeedEntity>, GetNewsBySourceUseCaseParams> {
  final Repository _repository;

  GetNewsBySourceUseCase(this._repository);

  @override
  Future<List<NewsFeedEntity>> call(GetNewsBySourceUseCaseParams params) {
    try {
      return this._repository.getNewsBySource(params.source,
          sortBy: params.sortBy, page: params.page, language: params.language);
    } catch (e) {
      log('GetNewsBySourceUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsBySourceUseCaseParams extends Equatable {
  final NewsSourceEntity source;
  final SortBy sortBy;
  final int page;
  final Language language;

  GetNewsBySourceUseCaseParams(
      {this.source, this.sortBy, this.page, this.language});

  @override
  List<Object> get props => [source, sortBy, page, language];
}
