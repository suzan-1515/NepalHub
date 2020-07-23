import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/data/models/sort.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'news_category_feed_store.g.dart';

class NewsCategoryFeedStore = _NewsCategoryFeedStore
    with _$NewsCategoryFeedStore;

abstract class _NewsCategoryFeedStore with Store {
  final NewsRepository _newsRepository;
  final NewsCategory _categoryModel;

  _NewsCategoryFeedStore(this._newsRepository, this._categoryModel);

  StreamController<List<NewsFeed>> _dataStreamController =
      StreamController<List<NewsFeed>>.broadcast();
  Stream<List<NewsFeed>> get dataStream => _dataStreamController.stream;

  @observable
  ObservableList<NewsSource> sources = ObservableList();

  List<NewsFeed> _data = List<NewsFeed>();

  bool _isLoading = false;
  bool _hasMore = false;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  NewsCategory get categoryModel => _categoryModel;

  @observable
  SortBy sort = SortBy.RELEVANCE;

  @observable
  NewsSource selectedSource;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  void loadInitialData() {
    _loadNewsSources().whenComplete(() => _loadFirstPageData());
  }

  @action
  void retry() {
    _loadFirstPageData();
  }

  @action
  Future refresh() {
    return _loadFirstPageData();
  }

  @action
  Future _loadFirstPageData() async {
    if (isLoading) return;
    _isLoading = true;
    _dataStreamController.add(null);
    _data.clear();
    return _newsRepository
        .getFeedsByCategory(
            category: categoryModel.code,
            source: selectedSource?.code,
            sort: sort)
        .then((onValue) {
      if (onValue != null) {
        _data.addAll(onValue);
        _hasMore = true;
      } else
        _hasMore = false;
      _dataStreamController.add(_data);
    }).catchError((onError) {
      this.apiError = onError;
      _dataStreamController.addError(error);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
      _dataStreamController.addError(error);
    }).whenComplete(() => _isLoading = false);
  }

  @action
  Future loadMoreData() async {
    if (isLoading) return;
    _isLoading = true;
    return _newsRepository
        .getFeedsByCategory(
            category: categoryModel.code,
            lastFeedId: _data?.last?.id,
            source: selectedSource?.code,
            sort: sort)
        .then((onValue) {
      if (onValue != null) {
        _data.addAll(onValue);
        _hasMore = true;
      } else
        _hasMore = false;
      _dataStreamController.add(_data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
    }).whenComplete(() => _isLoading = false);
  }

  @action
  Future _loadNewsSources() {
    return _newsRepository
        .getSources(followedOnly: true)
        .then((value) {
          if (value != null) sources = ObservableList.of(value);
        })
        .catchError((onError) {}, test: (e) => e is APIException)
        .catchError((onError) {});
  }

  @action
  setSortBy(SortBy value) {
    this.sort = value;
    refresh();
  }

  @action
  setSource(NewsSource source) {
    this.selectedSource = source;
    refresh();
  }

  dispose() {
    _dataStreamController.close();
  }
}
