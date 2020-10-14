import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class ShareForexUseCase
    implements UseCase<ForexEntity, ShareForexUseCaseParams> {
  final Repository _repository;

  ShareForexUseCase(this._repository);

  @override
  Future<ForexEntity> call(ShareForexUseCaseParams params) {
    try {
      return this._repository.share(params.forexEntity);
    } catch (e) {
      log('ShareForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ShareForexUseCaseParams extends Equatable {
  final ForexEntity forexEntity;

  ShareForexUseCaseParams({@required this.forexEntity});

  @override
  List<Object> get props => [forexEntity];
}
