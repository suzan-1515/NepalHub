import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/pages/forex/forex_repository.dart';

part 'forex_store.g.dart';

class ForexStore = _ForexStore with _$ForexStore;

abstract class _ForexStore with Store {
  final ForexRepository _forexRepository;

  _ForexStore(this._forexRepository);

  StreamController<List<ForexModel>> _dataStreamController =
      StreamController<List<ForexModel>>.broadcast();

  Stream<List<ForexModel>> get dataStream => _dataStreamController.stream;

  List<ForexModel> _data = List<ForexModel>();
  bool _isLoading = false;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  Future<void> refresh() async {
    return _loadTodayData();
  }

  @action
  void retry() {
    _loadTodayData();
  }

  @action
  loadData() {
    _loadTodayData();
  }

  @action
  Future _loadTodayData() async {
    if (_isLoading) return;
    _isLoading = true;
    _forexRepository.getToday().then((value) {
      if (value != null) {
        _data.clear();
        _data.addAll(value);
      }
      _dataStreamController.add(_data);
    }).catchError((onError) {
      this.apiError = onError;
      _dataStreamController.addError(onError);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = 'Unable to load data';
      _dataStreamController.addError(onError);
    }).whenComplete(() => _isLoading = false);
  }

  dispose(){
    _dataStreamController.close();
  }
}
