import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class UndislikeGoldSilverUseCase
    implements UseCase<GoldSilverEntity, UndislikeGoldSilverUseCaseParams> {
  final Repository _repository;

  UndislikeGoldSilverUseCase(this._repository);

  @override
  Future<GoldSilverEntity> call(UndislikeGoldSilverUseCaseParams params) {
    try {
      return this._repository.undislike(params.goldSilverEntity);
    } catch (e) {
      log('UndislikeGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UndislikeGoldSilverUseCaseParams extends Equatable {
  final GoldSilverEntity goldSilverEntity;

  UndislikeGoldSilverUseCaseParams({@required this.goldSilverEntity});

  @override
  List<Object> get props => [goldSilverEntity];
}
