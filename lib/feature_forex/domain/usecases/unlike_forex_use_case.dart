import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class UnlikeForexUseCase
    implements UseCase<ForexEntity, UnlikeForexUseCaseParams> {
  final Repository _repository;

  UnlikeForexUseCase(this._repository);

  @override
  Future<ForexEntity> call(UnlikeForexUseCaseParams params) {
    try {
      return this._repository.unlike(params.forexEntity);
    } catch (e) {
      log('UnlikeForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnlikeForexUseCaseParams extends Equatable {
  final ForexEntity forexEntity;

  UnlikeForexUseCaseParams({@required this.forexEntity});

  @override
  List<Object> get props => [forexEntity];
}
