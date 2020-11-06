import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class DislikeGoldSilverUseCase
    implements UseCase<GoldSilverEntity, DislikeGoldSilverUseCaseParams> {
  final Repository _repository;

  DislikeGoldSilverUseCase(this._repository);

  @override
  Future<GoldSilverEntity> call(DislikeGoldSilverUseCaseParams params) {
    try {
      return this._repository.dislike(params.goldSilverEntity);
    } catch (e) {
      log('DislikeGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class DislikeGoldSilverUseCaseParams extends Equatable {
  final GoldSilverEntity goldSilverEntity;

  DislikeGoldSilverUseCaseParams({@required this.goldSilverEntity});

  @override
  List<Object> get props => [goldSilverEntity];
}
