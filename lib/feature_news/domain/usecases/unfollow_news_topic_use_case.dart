import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class UnFollowNewsTopicUseCase
    implements UseCase<NewsTopicEntity, UnFollowNewsTopicUseCaseParams> {
  final Repository _repository;

  UnFollowNewsTopicUseCase(this._repository);

  @override
  Future<NewsTopicEntity> call(UnFollowNewsTopicUseCaseParams params) {
    try {
      return this._repository.unFollowTopic(params.topic);
    } catch (e) {
      log('UnFollowNewsTopicUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnFollowNewsTopicUseCaseParams extends Equatable {
  final NewsTopicEntity topic;

  UnFollowNewsTopicUseCaseParams({this.topic});

  @override
  List<Object> get props => [topic];
}
