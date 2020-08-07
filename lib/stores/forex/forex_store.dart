import 'dart:async';

import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/services/preference_service.dart';

part 'forex_store.g.dart';

class ForexStore = _ForexStore with _$ForexStore;

abstract class _ForexStore with Store {
  final ForexRepository _forexRepository;
  final PreferenceService _preferenceService;

  _ForexStore(this._forexRepository, this._preferenceService);

  StreamController<List<ForexModel>> _dataStreamController =
      StreamController<List<ForexModel>>.broadcast();

  Stream<List<ForexModel>> get dataStream => _dataStreamController.stream;

  List<ForexModel> _data = List<ForexModel>();
  bool _isLoading = false;

  @observable
  ObservableList<ForexModel> defaultForexTimeline =
      ObservableList<ForexModel>();

  @computed
  ForexModel get defaultForex {
    if (defaultForexTimeline.isEmpty) return null;
    return defaultForexTimeline.last;
  }

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
    _loadTodayData();
    _loadDefaultCurrencyTimelineData();
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

  @action
  Future _loadDefaultCurrencyTimelineData() async {
    final DateFormat df = DateFormat('yyyy-MM-dd');
    final toDate = df.format(DateTime.now());
    final fromDate = df.format(DateTime.now().subtract(Duration(days: 30)));
    final defaultCurrency = _preferenceService.defaultForexCurrency;
    return _forexRepository
        .getByCountry(
      currencyCode: defaultCurrency,
      fromDate: fromDate,
      toDate: toDate,
    )
        .then((value) {
      if (value != null) {
        defaultForexTimeline.clear();
        defaultForexTimeline.addAll(value);
      }
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = 'Unable to load data';
    });
  }

  dispose() {
    _dataStreamController.close();
  }
}
