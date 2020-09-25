import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetFollowedNewsSourcesUseCase
    implements UseCase<List<NewsSourceEntity>, NoParams> {
  final Repository _repository;

  GetFollowedNewsSourcesUseCase(this._repository);

  @override
  Future<List<NewsSourceEntity>> call(NoParams params) {
    try {
      return this._repository.getSources();
    } catch (e) {
      log('GetFollowedNewsSourcesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
