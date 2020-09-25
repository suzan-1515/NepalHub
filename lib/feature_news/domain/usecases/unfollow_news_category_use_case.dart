import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class UnFollowNewsCategoryUseCase
    implements UseCase<void, UnFollowNewsCategoryUseCaseParams> {
  final Repository _repository;

  UnFollowNewsCategoryUseCase(this._repository);

  @override
  Future<void> call(UnFollowNewsCategoryUseCaseParams params) {
    try {
      return this._repository.unFollowCategory(params.category);
    } catch (e) {
      log('UnFollowNewsCategoryUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnFollowNewsCategoryUseCaseParams extends Equatable {
  final NewsCategoryEntity category;

  UnFollowNewsCategoryUseCaseParams({this.category});

  @override
  List<Object> get props => [category];
}
