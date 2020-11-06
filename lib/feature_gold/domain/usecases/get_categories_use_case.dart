import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_category_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class GetGoldSilverCategoriesUseCase
    implements
        UseCase<List<GoldSilverCategoryEntity>,
            GetGoldSilverCategoriesUseCaseParams> {
  final Repository _repository;

  GetGoldSilverCategoriesUseCase(this._repository);

  @override
  Future<List<GoldSilverCategoryEntity>> call(
      GetGoldSilverCategoriesUseCaseParams params) {
    try {
      return this._repository.getCategories(language: params.language);
    } catch (e) {
      log('GetGoldSilverCategoriesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetGoldSilverCategoriesUseCaseParams extends Equatable {
  final Language language;

  GetGoldSilverCategoriesUseCaseParams({
    @required this.language,
  });

  @override
  List<Object> get props => [language];
}
