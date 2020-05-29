import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
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

  StreamController<List<NewsFeedModel>> _dataStreamController =
      StreamController<List<NewsFeedModel>>.broadcast();

  Stream<List<NewsFeedModel>> get dataStream => _dataStreamController.stream;

  _PersonalisedFeedStore(this._newsRepository,
      this._horoscopeRepository, this._forexRepository);

  Map<MixedDataType, dynamic> sectionData = Map<MixedDataType, dynamic>();

  List<NewsFeedModel> data = List<NewsFeedModel>();

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
    return _newsRepository
        .getTopics()
        .then((onValue) {
          sectionData[MixedDataType.NEWS_TOPIC] = onValue;
        })
        .catchError((onError) {}, test: (e) => e is APIException)
        .catchError((onError) {});
  }

  Future _buildNewsSourceData() async {
    return _newsRepository
        .getSources()
        .then((onValue) {
          sectionData[MixedDataType.NEWS_SOURCE] = onValue;
        })
        .catchError((onError) {}, test: (e) => e is APIException)
        .catchError((onError) {});
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

  dispose(){
    _dataStreamController.close();
  }
}
