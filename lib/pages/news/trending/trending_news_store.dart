import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';

part 'trending_news_store.g.dart';

class TrendingNewsStore = _TrendingNewsStore with _$TrendingNewsStore;

abstract class _TrendingNewsStore with Store {
  final NewsRepository _newsRepository;

  StreamController<List<NewsFeedModel>> _dataStreamController =
      StreamController<List<NewsFeedModel>>.broadcast();

  Stream<List<NewsFeedModel>> get dataStream => _dataStreamController.stream;

  List<NewsFeedModel> data = List<NewsFeedModel>();
  bool _isLoadingMore = false;
  bool _hasMoreData = false;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;

  _TrendingNewsStore(this._newsRepository);

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  Future<void> refresh() async {
    return _loadFirstPageData();
  }

  @action
  void retry() {
    _loadFirstPageData();
  }

  @action
  loadData() {
    _loadFirstPageData();
  }

  @action
  Future _loadFirstPageData() {
    data.clear();
    return _loadMoreData(after: null);
  }

  Future<void> _loadMoreData({@required String after}) async {
    if (isLoadingMore) return;
    _isLoadingMore = true;
    return _newsRepository.getTrendingFeeds().then((onValue) {
      _isLoadingMore = false;
      if (onValue != null) {
        data.addAll(onValue);
      }
      _hasMoreData = (onValue != null && onValue.isNotEmpty);
      _dataStreamController.add(data);
    }).catchError((onError) {
      _isLoadingMore = false;
      _hasMoreData = false;
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError((onError) {
      _isLoadingMore = false;
      _hasMoreData = false;
      this.error = onError.toString();
    });
  }

  dispose() {
    _dataStreamController.close();
  }
}
