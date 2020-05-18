import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/repository/corona_repository.dart';

part 'corona_store.g.dart';

class CoronaStore = _CoronaStore with _$CoronaStore;

abstract class _CoronaStore with Store {
  final CoronaRepository _coronaRepository;
  final PreferenceService _preferenceService;

  StreamController<CoronaWorldwide> _worldwideDataStreamController =
      StreamController<CoronaWorldwide>.broadcast();
  StreamController<CoronaCountrySpecific> _nepalDataStreamController =
      StreamController<CoronaCountrySpecific>.broadcast();

  Stream<CoronaWorldwide> get worldwideDataStream =>
      _worldwideDataStreamController.stream;
  Stream<CoronaCountrySpecific> get nepalDataStream =>
      _nepalDataStreamController.stream;

  _CoronaStore(this._preferenceService, this._coronaRepository);

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  loadWorldwideData() {
    _coronaRepository.getWorldwideStat().then((onValue) {
      _worldwideDataStreamController.add(onValue);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  @action
  loadNepalData() {
    _coronaRepository.getByCountry().then((onValue) {
      _nepalDataStreamController.add(onValue);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  dispose() {
    _worldwideDataStreamController.close();
    _nepalDataStreamController.close();
  }
}
