import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/repository/corona_repository.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/util/news_category.dart';

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

  // List<Feed> latestNewsData = List<Feed>();

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

  buildData() {
    //Clear all data
    data.clear();

    //build new category menu section
    data.addAll([
      SectionHeading(
          'Discover', 'Get the latest news on your favourite category'),
      newsCategoryMenus,
    ]);

    //TODO: build news tags section
    _newsRepository.getTags().then((onValue) {
      data.addAll([
        SectionHeading('Trending Topics',
            'Get the latest news on currently trending topics'),
        onValue
      ]);
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
    });

    //TODO: build news sources menu section
    _newsRepository.getSources().then((onValue) {
      data.addAll([
        SectionHeading(
            'News Sources', 'Explore news from your favourite news sources'),
        onValue
      ]);
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());

    //TODO: build trending news section

    //build latest news section
    _newsRepository.getLatestFeeds().then((onValue) {
      data.add(
        SectionHeading('Latest stories for you',
            'Latest news from various sources and categories'),
      );
      data.addAll(onValue);
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());

  }

  @action
  setView(MenuItem value) {
    view = value;
  }
}
