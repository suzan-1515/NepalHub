import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class UndislikeForexUseCase
    implements UseCase<ForexEntity, UndislikeForexUseCaseParams> {
  final Repository _repository;

  UndislikeForexUseCase(this._repository);

  @override
  Future<ForexEntity> call(UndislikeForexUseCaseParams params) {
    try {
      return this._repository.undislike(params.forexEntity);
    } catch (e) {
      log('UndislikeForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UndislikeForexUseCaseParams extends Equatable {
  final ForexEntity forexEntity;

  UndislikeForexUseCaseParams({@required this.forexEntity});

  @override
  List<Object> get props => [forexEntity];
}
