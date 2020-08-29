import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/corona_repository.dart';

part 'corona_store.g.dart';

class CoronaStore = _CoronaStore with _$CoronaStore;

abstract class _CoronaStore with Store {
  final CoronaRepository _coronaRepository;

  StreamController<CoronaWorldwideModel> _worldwideDataStreamController =
      StreamController<CoronaWorldwideModel>.broadcast();
  StreamController<CoronaCountrySpecificModel> _nepalDataStreamController =
      StreamController<CoronaCountrySpecificModel>.broadcast();

  Stream<CoronaWorldwideModel> get worldwideDataStream =>
      _worldwideDataStreamController.stream;
  Stream<CoronaCountrySpecificModel> get nepalDataStream =>
      _nepalDataStreamController.stream;

  _CoronaStore(this._coronaRepository);

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
