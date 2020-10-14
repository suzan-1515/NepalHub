import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class DislikeForexUseCase
    implements UseCase<ForexEntity, DislikeForexUseCaseParams> {
  final Repository _repository;

  DislikeForexUseCase(this._repository);

  @override
  Future<ForexEntity> call(DislikeForexUseCaseParams params) {
    try {
      return this._repository.dislike(params.forexEntity);
    } catch (e) {
      log('DislikeForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class DislikeForexUseCaseParams extends Equatable {
  final ForexEntity forexEntity;

  DislikeForexUseCaseParams({@required this.forexEntity});

  @override
  List<Object> get props => [forexEntity];
}
