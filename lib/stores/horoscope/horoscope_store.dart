import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/services/preference_service.dart';

part 'horoscope_store.g.dart';

class HoroscopeStore = _HoroscopeStore with _$HoroscopeStore;

abstract class _HoroscopeStore with Store {
  final HoroscopeRepository _horoscopeRepository;
  final PreferenceService _preferenceService;

  _HoroscopeStore(this._horoscopeRepository, this._preferenceService) {
    defaultZodiac = _preferenceService.defaultZodiac;
  }

  StreamController<Map<HoroscopeType, HoroscopeModel>> _dataStreamController =
      StreamController<Map<HoroscopeType, HoroscopeModel>>.broadcast();

  Stream<Map<HoroscopeType, HoroscopeModel>> get dataStream =>
      _dataStreamController.stream;

  bool _isLoading = false;

  @observable
  int defaultZodiac = 0;

  @observable
  int activeTabIndex = 0;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  void retry() {
    loadData();
  }

  @action
  loadData() {
    _loadData();
  }

  @action
  Future _loadData() async {
    if (_isLoading) return;
    _isLoading = true;
    _horoscopeRepository.getHoroscope().then((value) {
      _dataStreamController.add(value);
    }).catchError((onError) {
      this.apiError = onError;
      _dataStreamController.addError(onError);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = 'Unable to load data';
      _dataStreamController.addError(onError);
    }).whenComplete(() => _isLoading = false);
  }

  dispose() {
    _dataStreamController.close();
  }
}
