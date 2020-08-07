import 'dart:async';
import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/horoscope_type.dart';
import 'package:samachar_hub/pages/corona/corona_repository.dart';
import 'package:samachar_hub/pages/home/home_screen.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/utils/content_view_type.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final NewsRepository _newsRepository;
  final HoroscopeRepository _horoscopeRepository;
  final ForexRepository _forexRepository;
  final CoronaRepository _coronaRepository;

  StreamController<Map<MixedDataType, dynamic>> _dataStreamController =
      StreamController<Map<MixedDataType, dynamic>>.broadcast();

  Stream<Map<MixedDataType, dynamic>> get dataStream =>
      _dataStreamController.stream;

  _HomeStore(this._newsRepository, this._horoscopeRepository,
      this._forexRepository, this._coronaRepository);

  Map<MixedDataType, dynamic> _data = Map<MixedDataType, dynamic>();

  @observable
  APIException apiError;

  @observable
  String error;

  @observable
  ContentViewStyle view = ContentViewStyle.THUMBNAIL_VIEW;

  bool _isBuilding = false;

  @observable
  int selectedPage = 0;

  @action
  setPage(int pageIndex) {
    selectedPage = pageIndex;
  }

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
    if (_isBuilding) return;
    _isBuilding = true;

    _data.clear();
    await Future.wait(
      [
        _loadDateWeatherData(),
        _loadCoronaData(),
        _loadTrendingNewsData(),
        _loadLatestNewsData(),
        _loadNewsTopicsData(),
        _loadNewsCategoryData(),
        _loadNewsSourceData(),
        _loadForexData(),
        _loadHoroscopeData(),
      ],
    ).catchError((onError) {
      this.apiError = onError;
      _dataStreamController.addError(onError);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
    });

    _dataStreamController.add(_data);

    _isBuilding = false;
  }

  @action
  setView(ContentViewStyle value) {
    view = value;
  }

  Future<bool> _loadDateWeatherData() async {
    _data[MixedDataType.DATE_INFO] = null;
    return true;
  }

  Future<bool> _loadNewsTopicsData() async {
    return _newsRepository.getTopics().then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        _data[MixedDataType.NEWS_TOPIC] = onValue;
        return true;
      }
      return false;
    }).catchError((onError) => false);
  }

  Future<bool> _loadNewsSourceData() async {
    return _newsRepository.getSources(followedOnly: true).then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        _data[MixedDataType.NEWS_SOURCE] = onValue;
        return true;
      }
      return false;
    }).catchError((onError) => false);
  }

  Future<bool> _loadNewsCategoryData() async {
    return _newsRepository.getCategories(followedOnly: true).then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        _data[MixedDataType.NEWS_CATEGORY] = onValue;
        return true;
      }
      return false;
    }).catchError((onError) => false);
  }

  Future<bool> _loadTrendingNewsData({String limit = '5'}) {
    return _newsRepository.getTrendingFeeds(limit: limit).then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        _data[MixedDataType.TRENDING_NEWS] = onValue;
        return true;
      }
      return false;
    }).catchError((onError) {
      log('Trending news section data error', stackTrace: onError);
      return false;
    });
  }

  Future<bool> _loadLatestNewsData() async {
    return _newsRepository.getLatestFeeds().then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        _data[MixedDataType.LATEST_NEWS] = onValue;
        return true;
      }
      return false;
    });
  }

  Future<bool> _loadCoronaData() async {
    return _coronaRepository.getByCountry().then((onValue) {
      if (onValue != null) {
        _data[MixedDataType.CORONA] = onValue;
        return true;
      }
      return false;
    }).catchError((onError) {
      log('Corona section data error', stackTrace: onError);
      return false;
    });
  }

  Future<bool> _loadForexData() async {
    return _forexRepository.getToday().then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        var defaultForex = onValue.firstWhere(
          (element) => element.isDefault,
          orElse: () => onValue.first,
        );
        _data[MixedDataType.FOREX] = defaultForex;
        return true;
      }
      return false;
    }).catchError((onError) {
      log('Forex data load error', stackTrace: onError);
      return false;
    });
  }

  Future<bool> _loadHoroscopeData() async {
    return _horoscopeRepository.getHoroscope().then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {
        var defaultHoroscope = onValue[HoroscopeType.DAILY];
        _data[MixedDataType.HOROSCOPE] = defaultHoroscope;
        return true;
      }
      return false;
    }).catchError((onError) {
      log('Horoscope data load error', stackTrace: onError);
      return false;
    });
  }

  @action
  Future loadMoreData() {
    return _buildData();
  }

  dispose() {
    _dataStreamController.close();
  }
}
