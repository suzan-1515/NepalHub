import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/repository/corona_repository.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/util/news_category.dart';

import 'personalised_item_builder.dart';

part 'personalised_store.g.dart';

class PersonalisedFeedStore = _PersonalisedFeedStore
    with _$PersonalisedFeedStore;

abstract class _PersonalisedFeedStore with Store {
  final NewsRepository _newsRepository;
  final CoronaRepository _coronaRepository;
  final HoroscopeRepository _horoscopeRepository;
  final ForexRepository _forexRepository;
  final PreferenceService _preferenceService;

  StreamController<List> _dataStreamController =
      StreamController<List>.broadcast();

  Stream<List> get dataStream => _dataStreamController.stream;

  _PersonalisedFeedStore(this._preferenceService, this._newsRepository,
      this._coronaRepository, this._horoscopeRepository, this._forexRepository);

  Map<MixedDataType, dynamic> sectionData = Map<MixedDataType, dynamic>();

  List data = List();

  @observable
  APIException apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.THUMBNAIL_VIEW;

  @action
  void loadInitialData() {
    buildData();
  }

  @action
  Future<void> refresh() async {
    return buildData();
  }

  @action
  void retry() {
    buildData();
  }

  buildData() async {
    data.clear();
    await _buildDateWeatherData();
    await _buildCoronaData();
    await _buildTrendingNewsData();

    _buildLatestNewsData();
    _buildNewsTopicsData();
    _buildNewsCategoryData();
    _buildNewsSourceData();
    // _buildForexData();
    // _buildHoroscopeData();
  }

  @action
  setView(MenuItem value) {
    view = value;
  }

  Future _buildDateWeatherData() {
    data.add(MixedDataType.DATE_INFO);
    _dataStreamController.add(data);
    return Future.value();
  }

  Future _buildTrendingNewsData() {
    data.add(MixedDataType.TRENDING_NEWS);
    _dataStreamController.add(data);
    return Future.value();
  }

  Future _buildNewsCategoryData() async {
    sectionData[MixedDataType.NEWS_CATEGORY] = newsCategoryMenus;
    return Future.value();
  }

  Future _buildNewsTopicsData() async {
    return _newsRepository.getTags().then((onValue) {
      sectionData[MixedDataType.NEWS_TOPIC] = onValue;
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
    });
  }

  Future _buildNewsSourceData() async {
    return _newsRepository.getSources().then((onValue) {
      sectionData[MixedDataType.NEWS_SOURCE] = onValue;
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  Future _buildLatestNewsData() async {
    return _newsRepository.getLatestFeeds().then((onValue) {
      sectionData[MixedDataType.LATEST_NEWS] = onValue;
      data.addAll(onValue);
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  Future _buildHoroscopeData() async {
    return _horoscopeRepository.getHoroscope().then((onValue) {
      sectionData[MixedDataType.HOROSCOPE] = onValue;
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  Future _buildCoronaData() async {
    data.add(MixedDataType.CORONA);
    _dataStreamController.add(data);
  }

  Future _buildForexData() async {
    return _forexRepository.getToday().then((onValue) {
      sectionData[MixedDataType.FOREX] = onValue;
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }
}
