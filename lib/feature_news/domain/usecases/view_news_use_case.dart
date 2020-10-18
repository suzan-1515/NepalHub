import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class ViewNewsUseCase
    implements UseCase<NewsFeedEntity, ViewNewsUseCaseParams> {
  final Repository _repository;

  ViewNewsUseCase(this._repository);

  @override
  Future<NewsFeedEntity> call(ViewNewsUseCaseParams params) {
    try {
      return this._repository.viewFeed(params.feed);
    } catch (e) {
      log('ViewNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ViewNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  ViewNewsUseCaseParams({@required this.feed});

  @override
  List<Object> get props => [feed];
}
