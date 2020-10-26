import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsDetailUseCase
    implements UseCase<NewsFeedEntity, GetNewsDetailUseCaseParams> {
  final Repository _repository;

  GetNewsDetailUseCase(this._repository);

  @override
  Future<NewsFeedEntity> call(GetNewsDetailUseCaseParams params) {
    try {
      return this._repository.getNewsDetail(params.feedId);
    } catch (e) {
      log('GetNewsDetailUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsDetailUseCaseParams extends Equatable {
  final String feedId;

  GetNewsDetailUseCaseParams({this.feedId});

  @override
  List<Object> get props => [feedId];
}
