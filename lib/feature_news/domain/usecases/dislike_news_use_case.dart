import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class DislikeNewsUseCase implements UseCase<void, DislikeNewsUseCaseParams> {
  final Repository _repository;

  DislikeNewsUseCase(this._repository);

  @override
  Future<void> call(DislikeNewsUseCaseParams params) {
    try {
      return this._repository.dislikeFeed(params.feed);
    } catch (e) {
      log('DislikeNewsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class DislikeNewsUseCaseParams extends Equatable {
  final NewsFeedEntity feed;

  DislikeNewsUseCaseParams({@required this.feed});

  @override
  List<Object> get props => [feed];
}
