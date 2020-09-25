import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class GetNewsSourcesUseCase
    implements UseCase<List<NewsSourceEntity>, GetNewsSourcesUseCaseParams> {
  final Repository _repository;

  GetNewsSourcesUseCase(this._repository);

  @override
  Future<List<NewsSourceEntity>> call(GetNewsSourcesUseCaseParams params) {
    try {
      return this._repository.getSources(language: params.language);
    } catch (e) {
      log('GetNewsSourcesUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetNewsSourcesUseCaseParams extends Equatable {
  final Language language;

  GetNewsSourcesUseCaseParams({this.language});

  @override
  List<Object> get props => [language];
}
