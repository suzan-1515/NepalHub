import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class ViewForexUseCase implements UseCase<void, ViewForexUseCaseParams> {
  final Repository _repository;

  ViewForexUseCase(this._repository);

  @override
  Future<void> call(ViewForexUseCaseParams params) {
    try {
      return this._repository.view(params.forexEntity);
    } catch (e) {
      log('ViewForexUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ViewForexUseCaseParams extends Equatable {
  final ForexEntity forexEntity;

  ViewForexUseCaseParams({@required this.forexEntity});

  @override
  List<Object> get props => [forexEntity];
}
