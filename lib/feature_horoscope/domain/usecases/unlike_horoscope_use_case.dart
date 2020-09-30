import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class UnlikeHoroscopeUseCase
    implements UseCase<void, UnlikeHoroscopeUseCaseParams> {
  final Repository _repository;

  UnlikeHoroscopeUseCase(this._repository);

  @override
  Future<void> call(UnlikeHoroscopeUseCaseParams params) {
    try {
      return this._repository.unlike(params.horoscopeEntity);
    } catch (e) {
      log('UnlikeHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnlikeHoroscopeUseCaseParams extends Equatable {
  final HoroscopeEntity horoscopeEntity;

  UnlikeHoroscopeUseCaseParams({@required this.horoscopeEntity});

  @override
  List<Object> get props => [horoscopeEntity];
}
