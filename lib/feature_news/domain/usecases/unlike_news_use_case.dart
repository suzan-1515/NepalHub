import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class UnlikeNewsUseCase
    implements UseCase<NewsFeedEntity, UnlikeNewsUseCaseParams> {
  final Repository _repository;

  UnlikeNewsUseCase(this._repository);

  @override
  Future<NewsFeedEntity> call(UnlikeNewsUseCaseParams params) {
    try {
      return this._repository.unlikeFeed(params.feed);
    } catch (e) {
      log('UnlikeNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnlikeNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  UnlikeNewsUseCaseParams({@required this.feed});

  @override
  List<Object> get props => [feed];
}
