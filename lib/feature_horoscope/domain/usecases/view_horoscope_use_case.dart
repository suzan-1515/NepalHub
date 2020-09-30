import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class ViewHoroscopeUseCase
    implements UseCase<void, ViewHoroscopeUseCaseParams> {
  final Repository _repository;

  ViewHoroscopeUseCase(this._repository);

  @override
  Future<void> call(ViewHoroscopeUseCaseParams params) {
    try {
      return this._repository.view(params.horoscopeEntity);
    } catch (e) {
      log('ViewHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ViewHoroscopeUseCaseParams extends Equatable {
  final HoroscopeEntity horoscopeEntity;

  ViewHoroscopeUseCaseParams({@required this.horoscopeEntity});

  @override
  List<Object> get props => [horoscopeEntity];
}
