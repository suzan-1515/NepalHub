import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'trending_news_store.g.dart';

class TrendingNewsStore = _TrendingNewsStore with _$TrendingNewsStore;

abstract class _TrendingNewsStore with Store {
  final NewsRepository _newsRepository;

  StreamController<List<NewsFeedModel>> _dataStreamController =
      StreamController<List<NewsFeedModel>>.broadcast();

  Stream<List<NewsFeedModel>> get dataStream => _dataStreamController.stream;

  List<NewsFeedModel> data = List<NewsFeedModel>();

  _TrendingNewsStore(this._newsRepository);

  @observable
  int currentNewsCarousel = 0;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  Future<void> refresh() async {
    return _loadData();
  }

  @action
  loadPreviewData() {
    _loadData(limit: '5');
  }

  @action
  loadFullData() {
    _loadData();
  }

  Future<void> _loadData({String limit}) {
    return _newsRepository.getTrendingFeeds(limit: limit).then((onValue) {
      if (onValue != null) {
        data.clear();
        data.addAll(onValue);
      }
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  dispose() {
    _dataStreamController.close();
  }
}
