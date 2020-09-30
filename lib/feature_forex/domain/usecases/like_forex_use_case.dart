import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class LikeForexUseCase implements UseCase<void, LikeForexUseCaseParams> {
  final Repository _repository;

  LikeForexUseCase(this._repository);

  @override
  Future<void> call(LikeForexUseCaseParams params) {
    try {
      return this._repository.like(params.forexEntity);
    } catch (e) {
      log('LikeForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class LikeForexUseCaseParams extends Equatable {
  final ForexEntity forexEntity;

  LikeForexUseCaseParams({@required this.forexEntity});

  @override
  List<Object> get props => [forexEntity];
}
