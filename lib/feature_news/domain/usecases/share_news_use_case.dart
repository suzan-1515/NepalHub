import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class ShareNewsUseCase
    implements UseCase<NewsFeedEntity, ShareNewsUseCaseParams> {
  final Repository _repository;

  ShareNewsUseCase(this._repository);

  @override
  Future<NewsFeedEntity> call(ShareNewsUseCaseParams params) {
    try {
      return this._repository.shareFeed(params.feed);
    } catch (e) {
      log('ShareNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ShareNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  ShareNewsUseCaseParams({@required this.feed});

  @override
  List<Object> get props => [feed];
}
