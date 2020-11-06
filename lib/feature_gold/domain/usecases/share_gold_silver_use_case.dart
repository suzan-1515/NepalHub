import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class ShareGoldSilverUseCase
    implements UseCase<GoldSilverEntity, ShareGoldSilverUseCaseParams> {
  final Repository _repository;

  ShareGoldSilverUseCase(this._repository);

  @override
  Future<GoldSilverEntity> call(ShareGoldSilverUseCaseParams params) {
    try {
      return this._repository.share(params.goldSilverEntity);
    } catch (e) {
      log('ShareGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ShareGoldSilverUseCaseParams extends Equatable {
  final GoldSilverEntity goldSilverEntity;

  ShareGoldSilverUseCaseParams({@required this.goldSilverEntity});

  @override
  List<Object> get props => [goldSilverEntity];
}
