import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetFollowedNewsCategoriesUseCase
    implements
        UseCase<List<NewsCategoryEntity>,
            GetFollowedNewsCategoriesUseCaseParams> {
  final Repository _repository;

  GetFollowedNewsCategoriesUseCase(this._repository);

  @override
  Future<List<NewsCategoryEntity>> call(
      GetFollowedNewsCategoriesUseCaseParams params) {
    try {
      return this._repository.getCategories(language: params.language);
    } catch (e) {
      log('GetFollowedNewsCategoriesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetFollowedNewsCategoriesUseCaseParams extends Equatable {
  final Language language;

  GetFollowedNewsCategoriesUseCaseParams({this.language});

  @override
  List<Object> get props => [language];
}
