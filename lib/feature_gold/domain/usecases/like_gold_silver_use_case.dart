import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class LikeGoldSilverUseCase
    implements UseCase<GoldSilverEntity, LikeGoldSilverUseCaseParams> {
  final Repository _repository;

  LikeGoldSilverUseCase(this._repository);

  @override
  Future<GoldSilverEntity> call(LikeGoldSilverUseCaseParams params) {
    try {
      return this._repository.like(params.goldSilverEntity);
    } catch (e) {
      log('LikeGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class LikeGoldSilverUseCaseParams extends Equatable {
  final GoldSilverEntity goldSilverEntity;

  LikeGoldSilverUseCaseParams({@required this.goldSilverEntity});

  @override
  List<Object> get props => [goldSilverEntity];
}
