import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/util/news_category.dart';

part 'personalised_store.g.dart';

class PersonalisedFeedStore = _PersonalisedFeedStore
    with _$PersonalisedFeedStore;

abstract class _PersonalisedFeedStore with Store {
  final NewsRepository _newsRepository;
  final HoroscopeRepository _horoscopeRepository;
  final ForexRepository _forexRepository;
  final PreferenceService _preferenceService;

  StreamController<List<Feed>> _dataStreamController =
      StreamController<List<Feed>>.broadcast();

  Stream<List<Feed>> get dataStream => _dataStreamController.stream;

  _PersonalisedFeedStore(this._preferenceService, this._newsRepository,
      this._horoscopeRepository, this._forexRepository);

  Map<MixedDataType, dynamic> sectionData = Map<MixedDataType, dynamic>();

  List<Feed> data = List<Feed>();

  @observable
  APIException apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.THUMBNAIL_VIEW;

  @action
  void loadInitialData() {
    print('loading personalised feed data');
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

  Future _buildForexData() async {
    return _forexRepository.getToday().then((onValue) {
      sectionData[MixedDataType.FOREX] = onValue;
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }
}
