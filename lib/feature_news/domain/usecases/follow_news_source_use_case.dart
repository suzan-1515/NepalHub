import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class FollowNewsSourceUseCase
    implements UseCase<void, FollowNewsSourceUseCaseParams> {
  final Repository _repository;

  FollowNewsSourceUseCase(this._repository);

  @override
  Future<void> call(FollowNewsSourceUseCaseParams params) {
    try {
      return this._repository.followSource(params.source);
    } catch (e) {
      log('FollowNewsSourceUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class FollowNewsSourceUseCaseParams extends Equatable {
  final NewsSourceEntity source;

  FollowNewsSourceUseCaseParams({this.source});

  @override
  List<Object> get props => [source];
}
