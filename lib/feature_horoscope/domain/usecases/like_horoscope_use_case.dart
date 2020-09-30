import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class LikeHoroscopeUseCase
    implements UseCase<void, LikeHoroscopeUseCaseParams> {
  final Repository _repository;

  LikeHoroscopeUseCase(this._repository);

  @override
  Future<void> call(LikeHoroscopeUseCaseParams params) {
    try {
      return this._repository.like(params.horoscopeEntity);
    } catch (e) {
      log('LikeHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class LikeHoroscopeUseCaseParams extends Equatable {
  final HoroscopeEntity horoscopeEntity;

  LikeHoroscopeUseCaseParams({@required this.horoscopeEntity});

  @override
  List<Object> get props => [horoscopeEntity];
}
