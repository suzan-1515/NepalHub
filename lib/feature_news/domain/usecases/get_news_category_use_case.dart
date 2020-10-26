import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsCategoriesUseCase
    implements
        UseCase<List<NewsCategoryEntity>, GetNewsCategoriesUseCaseParams> {
  final Repository _repository;

  GetNewsCategoriesUseCase(this._repository);

  @override
  Future<List<NewsCategoryEntity>> call(GetNewsCategoriesUseCaseParams params) {
    try {
      return this._repository.getCategories(language: params.language);
    } catch (e) {
      log('GetNewsCategoriesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsCategoriesUseCaseParams extends Equatable {
  final Language language;

  GetNewsCategoriesUseCaseParams({this.language});

  @override
  List<Object> get props => [language];
}
