import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  final NewsRepository _newsRepository;
  final String _category;

  final StreamController<List<NewsFeed>> _dataStreamController =
      StreamController<List<NewsFeed>>();

  _CategoryStore(this._newsRepository, this._category);

  Stream<List<NewsFeed>> get dataStream => _dataStreamController.stream;
  final List<NewsFeed> _data = List<NewsFeed>();

  bool _isLoading = false;
  bool _hasMore = false;

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  @observable
  String error;

  @observable
  APIException apiError;

  @action
  void loadInitialFeeds() {
    _loadFirstPageFeeds();
  }

  @action
  Future<void> _loadFirstPageFeeds() async {
    if (_isLoading) return;
    _isLoading = true;
    _data.clear();
    return _newsRepository
        .getFeedsByCategory(category: _category)
        .then((value) {
      if (value != null) {
        _data.addAll(value);
        _hasMore = true;
      } else
        _hasMore = false;
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
  Future<void> refresh() async {
    return _loadFirstPageFeeds();
  }

  @action
  void retry() {
    _loadFirstPageFeeds();
  }

  @action
  Future<void> loadMoreData() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    return _newsRepository
        .getFeedsByCategory(category: _category, lastFeedId: _data.last.uuid)
        .then((value) {
      if (value != null) {
        _data.addAll(value);
        _hasMore = true;
      } else
        _hasMore = false;
      _dataStreamController.add(_data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = 'Unable to load more data';
    }).whenComplete(() => _isLoading = false);
  }

  dispose() {
    _dataStreamController.close();
  }
}
