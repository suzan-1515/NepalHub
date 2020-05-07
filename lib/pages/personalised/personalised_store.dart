import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/data/dto/heading.dart';
import 'package:samachar_hub/data/dto/progress.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/pages/personalised/personalised_service.dart';
import 'package:samachar_hub/util/news_category.dart';

part 'personalised_store.g.dart';

class PersonalisedFeedStore = _PersonalisedFeedStore
    with _$PersonalisedFeedStore;

abstract class _PersonalisedFeedStore with Store {
  final PersonalisedFeedService _personalisedFeedService;
  final PreferenceService _preferenceService;

  StreamController<List> _dataStreamController =
      StreamController<List>.broadcast();

  Stream<List> get dataStream => _dataStreamController.stream;

  _PersonalisedFeedStore(
      this._preferenceService, this._personalisedFeedService);

  List<Feed> latestNewsData = List<Feed>();

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

  @action
  Future<void> loadLatestNews() async {
    try {
      List<Feed> moreNews = await _personalisedFeedService.getLatestFeeds();
      if (moreNews != null) {
        latestNewsData = moreNews;
      }
    } on APIException catch (apiError) {
      this.apiError = apiError;
      throw apiError;
    } on Exception catch (e) {
      this.error = e.toString();
      throw e;
    }
  }

  buildData(){
    //Clear all data
    latestNewsData.clear();
    data.clear();

    //add initial loading indicator
    _dataStreamController.add([LoadingData()]);

    //build new category menu section
    data.addAll([
      SectionHeading(
          'Discover', 'Get the latest news on your favourite category'),
      newsCategoryMenus,
    ]);

    //TODO: build news tags section
    //TODO: build news sources menu section
    //TODO: build trending news section

    data.addAll([
      SectionHeading('Latest stories for you',
          'Latest news from various sources and categories'),
    ]);
    var tempData = List.of(data);
    tempData.add(LoadingData());
    _dataStreamController.add(tempData);
    //build latest news section
    loadLatestNews().then((onValue) {
      //remove loading indicator
      data.addAll(latestNewsData);
      _dataStreamController.add(data);
    }).catchError((onError) {
      //remove loading indicator
      _dataStreamController.add(data);
    });
  }

  @action
  setView(MenuItem value) {
    view = value;
  }
}
