import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/repositories/repository.dart';

class GetDefaultHoroscopeSignUseCase implements UseCase<int, NoParams> {
  final Repository _repository;

  GetDefaultHoroscopeSignUseCase(this._repository);

  @override
  Future<int> call(NoParams params) {
    try {
      return this._repository.getDefaultHoroscopeSignIndex();
    } catch (e) {
      log('GetDefaultHoroscopeSignUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
