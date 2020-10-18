import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class FollowNewsCategoryUseCase
    implements UseCase<NewsCategoryEntity, FollowNewsCategoryUseCaseParams> {
  final Repository _repository;

  FollowNewsCategoryUseCase(this._repository);

  @override
  Future<NewsCategoryEntity> call(FollowNewsCategoryUseCaseParams params) {
    try {
      return this._repository.followCategory(params.category);
    } catch (e) {
      log('FollowNewsCategoryUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class FollowNewsCategoryUseCaseParams extends Equatable {
  final NewsCategoryEntity category;

  FollowNewsCategoryUseCaseParams({@required this.category});

  @override
  List<Object> get props => [category];
}
