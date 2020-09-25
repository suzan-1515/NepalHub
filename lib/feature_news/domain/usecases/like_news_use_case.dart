import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class LikeNewsUseCase implements UseCase<void, LikeNewsUseCaseParams> {
  final Repository _repository;

  LikeNewsUseCase(this._repository);

  @override
  Future<void> call(LikeNewsUseCaseParams params) {
    try {
      return this._repository.likeFeed(params.feed);
    } catch (e) {
      log('LikeNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class LikeNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  LikeNewsUseCaseParams({@required this.feed});

  @override
  List<Object> get props => [feed];
}
