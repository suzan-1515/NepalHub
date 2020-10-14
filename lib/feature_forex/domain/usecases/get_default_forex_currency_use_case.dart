import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/repositories/repository.dart';

class GetDefaultForexCurrencyUseCase implements UseCase<String, NoParams> {
  final Repository _repository;

  GetDefaultForexCurrencyUseCase(this._repository);

  @override
  Future<String> call(NoParams params) {
    try {
      return this._repository.getDefaultCurrencyCode();
    } catch (e) {
      log('GetDefaultForexCurrencyUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
