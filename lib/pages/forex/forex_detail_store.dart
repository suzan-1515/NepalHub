import 'dart:async';

import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/pages/forex/forex_repository.dart';

part 'forex_detail_store.g.dart';

class ForexDetailStore = _ForexDetailStore with _$ForexDetailStore;

abstract class _ForexDetailStore with Store {
  final ForexRepository _forexRepository;
  final ForexModel _forexModel;

  _ForexDetailStore(this._forexRepository, this._forexModel);

  StreamController<List<ForexModel>> _dataStreamController =
      StreamController<List<ForexModel>>.broadcast();

  Stream<List<ForexModel>> get dataStream => _dataStreamController.stream;

  ForexModel get forex => _forexModel;

  List<ForexModel> _data = List<ForexModel>();
  bool _isLoading = false;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  Future<void> refresh() async {
    return _loadCurrencyData();
  }

  @action
  void retry() {
    _loadCurrencyData();
  }

  @action
  loadData() {
    _loadCurrencyData();
  }

  @action
  Future _loadCurrencyData() async {
    if (_isLoading) return;
    _isLoading = true;
    final DateFormat df = DateFormat('yyyy-MM-dd');
    final toDate = df.format(DateTime.now());
    final fromDate = df.format(DateTime.now().subtract(Duration(days: 30)));
    return _forexRepository
        .getByCountry(
            currencyCode: _forexModel.code, fromDate: fromDate, toDate: toDate)
        .then((value) {
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

  dispose() {
    _dataStreamController.close();
  }
}
