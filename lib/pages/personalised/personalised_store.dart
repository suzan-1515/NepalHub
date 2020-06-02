import 'dart:async';
import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/horoscope_type.dart';
import 'package:samachar_hub/pages/corona/corona_repository.dart';
import 'package:samachar_hub/pages/forex/forex_repository.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_repository.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/util/news_category.dart';

part 'personalised_store.g.dart';

class PersonalisedFeedStore = _PersonalisedFeedStore
    with _$PersonalisedFeedStore;

abstract class _PersonalisedFeedStore with Store {
  final NewsRepository _newsRepository;
  final HoroscopeRepository _horoscopeRepository;
  final ForexRepository _forexRepository;
  final CoronaRepository _coronaRepository;

  StreamController<List> _dataStreamController =
      StreamController<List>.broadcast();

  Stream<List> get dataStream => _dataStreamController.stream;

  _PersonalisedFeedStore(this._newsRepository, this._horoscopeRepository,
      this._forexRepository, this._coronaRepository);

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
    _buildData();
  }

  @action
  Future<void> refresh() async {
    return _buildData();
  }

  @action
  void retry() {
    _buildData();
  }

  @action
  Future _buildData() async {
    data.clear();
    _buildLatestNewsData();
    _loadTrendingNewsData();
    _loadCoronaData();
    _buildNewsTopicsData();
    _buildNewsCategoryData();
    _buildNewsSourceData();
    _buildForexData();
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

  Future<void> _loadTrendingNewsData({String limit = '5'}) {
    return _newsRepository.getTrendingFeeds(limit: limit).then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        sectionData[MixedDataType.TRENDING_NEWS] = onValue;
        _dataStreamController.add([MixedDataType.TRENDING_NEWS]);
      }
    }).catchError((onError) {
      log('Trending news section data error', stackTrace: onError);
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  Future _buildLatestNewsData() async {
    return _newsRepository.getLatestFeeds().then((onValue) {
      sectionData[MixedDataType.LATEST_NEWS] = onValue;
      _dataStreamController.add([MixedDataType.LATEST_NEWS]);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  Future _loadCoronaData() async {
    return _coronaRepository.getByCountry().then((onValue) {
      if (onValue != null) {
        sectionData[MixedDataType.CORONA] = onValue;
        _dataStreamController.add([MixedDataType.CORONA]);
      }
    }).catchError((onError) {
      log('Corona section data error', stackTrace: onError);
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  Future _buildHoroscopeData() async {
    return _horoscopeRepository.getHoroscope().then((onValue) {
      if (onValue != null) {
        sectionData[MixedDataType.HOROSCOPE] = onValue[HoroscopeType.DAILY];
      }
    }).catchError((onError) {
      log('Horoscope data error', stackTrace: onError);
    }, test: (e) => e is APIException).catchError(
        (onError) => log('Horoscope data error', stackTrace: onError));
  }

  Future _buildForexData() async {
    return _forexRepository.getToday().then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        var defaultForex = onValue.firstWhere(
          (element) => element.code == 'USD',
          orElse: () => null,
        );
        sectionData[MixedDataType.FOREX] = defaultForex;
      }
    }).catchError((onError) {
      log('Forex data error', stackTrace: onError);
    }, test: (e) => e is APIException).catchError(
        (onError) => log('Forex data error', stackTrace: onError));
  }

  dispose() {
    _dataStreamController.close();
  }
}
