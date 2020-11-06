import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';

class ViewGoldSilverUseCase
    implements UseCase<GoldSilverEntity, ViewGoldSilverUseCaseParams> {
  final Repository _repository;

  ViewGoldSilverUseCase(this._repository);

  @override
  Future<GoldSilverEntity> call(ViewGoldSilverUseCaseParams params) {
    try {
      return this._repository.view(params.goldSilverEntity);
    } catch (e) {
      log('ViewGoldSilverUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ViewGoldSilverUseCaseParams extends Equatable {
  final GoldSilverEntity goldSilverEntity;

  ViewGoldSilverUseCaseParams({@required this.goldSilverEntity});

  @override
  List<Object> get props => [goldSilverEntity];
}
