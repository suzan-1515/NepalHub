import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class ShareHoroscopeUseCase
    implements UseCase<void, ShareHoroscopeUseCaseParams> {
  final Repository _repository;

  ShareHoroscopeUseCase(this._repository);

  @override
  Future<void> call(ShareHoroscopeUseCaseParams params) {
    try {
      return this._repository.share(params.horoscopeEntity);
    } catch (e) {
      log('ShareHoroscopeUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class ShareHoroscopeUseCaseParams extends Equatable {
  final HoroscopeEntity horoscopeEntity;

  ShareHoroscopeUseCaseParams({@required this.horoscopeEntity});

  @override
  List<Object> get props => [horoscopeEntity];
}
