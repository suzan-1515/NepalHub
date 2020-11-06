import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class UnlikeGoldSilverUseCase
    implements UseCase<GoldSilverEntity, UnlikeGoldSilverUseCaseParams> {
  final Repository _repository;

  UnlikeGoldSilverUseCase(this._repository);

  @override
  Future<GoldSilverEntity> call(UnlikeGoldSilverUseCaseParams params) {
    try {
      return this._repository.unlike(params.goldSilverEntity);
    } catch (e) {
      log('UnlikeGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnlikeGoldSilverUseCaseParams extends Equatable {
  final GoldSilverEntity goldSilverEntity;

  UnlikeGoldSilverUseCaseParams({@required this.goldSilverEntity});

  @override
  List<Object> get props => [goldSilverEntity];
}
