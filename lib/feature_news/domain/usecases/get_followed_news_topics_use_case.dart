import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetFollowedNewsTopicsUseCase
    implements UseCase<List<NewsTopicEntity>, NoParams> {
  final Repository _repository;

  GetFollowedNewsTopicsUseCase(this._repository);

  @override
  Future<List<NewsTopicEntity>> call(NoParams params) {
    try {
      return this._repository.getTopics();
    } catch (e) {
      log('GetFollowedNewsTopicsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
