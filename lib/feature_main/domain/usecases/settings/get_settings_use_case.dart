import 'dart:developer';

import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class GetSettingsUseCase implements UseCase<SettingsEntity, NoParams> {
  final Repository _repository;

  GetSettingsUseCase(this._repository);

  @override
  Future<SettingsEntity> call(NoParams params) {
    try {
      return this._repository.getSettings();
    } catch (e) {
      log('GetSettingsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}
