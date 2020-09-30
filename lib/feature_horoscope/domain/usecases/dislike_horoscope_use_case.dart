import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class DislikeHoroscopeUseCase
    implements UseCase<void, DislikeHoroscopeUseCaseParams> {
  final Repository _repository;

  DislikeHoroscopeUseCase(this._repository);

  @override
  Future<void> call(DislikeHoroscopeUseCaseParams params) {
    try {
      return this._repository.dislike(params.horoscopeEntity);
    } catch (e) {
      log('DislikeHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class DislikeHoroscopeUseCaseParams extends Equatable {
  final HoroscopeEntity horoscopeEntity;

  DislikeHoroscopeUseCaseParams({@required this.horoscopeEntity});

  @override
  List<Object> get props => [horoscopeEntity];
}
