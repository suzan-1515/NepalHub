import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class UnFollowNewsSourceUseCase
    implements UseCase<NewsSourceEntity, UnFollowNewsSourceUseCaseParams> {
  final Repository _repository;

  UnFollowNewsSourceUseCase(this._repository);

  @override
  Future<NewsSourceEntity> call(UnFollowNewsSourceUseCaseParams params) {
    try {
      return this._repository.unFollowSource(params.source);
    } catch (e) {
      log('UnFollowNewsSourceUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnFollowNewsSourceUseCaseParams extends Equatable {
  final NewsSourceEntity source;

  UnFollowNewsSourceUseCaseParams({this.source});

  @override
  List<Object> get props => [source];
}
