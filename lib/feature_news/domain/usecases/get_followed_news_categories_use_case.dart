import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetFollowedNewsCategoriesUseCase
    implements UseCase<List<NewsCategoryEntity>, NoParams> {
  final Repository _repository;

  GetFollowedNewsCategoriesUseCase(this._repository);

  @override
  Future<List<NewsCategoryEntity>> call(NoParams params) {
    try {
      return this._repository.getCategories();
    } catch (e) {
      log('GetFollowedNewsCategoriesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
