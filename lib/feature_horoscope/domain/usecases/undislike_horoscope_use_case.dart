import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class UndislikeHoroscopeUseCase
    implements UseCase<void, UndislikeHoroscopeUseCaseParams> {
  final Repository _repository;

  UndislikeHoroscopeUseCase(this._repository);

  @override
  Future<void> call(UndislikeHoroscopeUseCaseParams params) {
    try {
      return this._repository.undislike(params.horoscopeEntity);
    } catch (e) {
      log('UndislikeHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UndislikeHoroscopeUseCaseParams extends Equatable {
  final HoroscopeEntity horoscopeEntity;

  UndislikeHoroscopeUseCaseParams({@required this.horoscopeEntity});

  @override
  List<Object> get props => [horoscopeEntity];
}
