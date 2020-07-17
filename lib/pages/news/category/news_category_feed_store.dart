import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';

part 'news_category_feed_store.g.dart';

class NewsCategoryFeedStore = _NewsCategoryFeedStore
    with _$NewsCategoryFeedStore;

abstract class _NewsCategoryFeedStore with Store {
  final NewsRepository _newsRepository;
  final NewsCategoryModel categoryModel;

  _NewsCategoryFeedStore(this._newsRepository, this.categoryModel);

  StreamController<List<NewsFeedModel>> _dataStreamController =
      StreamController<List<NewsFeedModel>>.broadcast();
  Stream<List<NewsFeedModel>> get dataStream => _dataStreamController.stream;

  List<NewsFeedModel> _data = List<NewsFeedModel>();

  bool _isLoading = false;
  bool _hasMore = false;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  void loadInitialData() {
    _loadFirstPageData();
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
    _data.clear();
    return _newsRepository
        .getFeedsByCategory(category: categoryModel.code)
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
            category: categoryModel.code, lastFeedId: _data?.last?.id)
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

  dispose() {
    _dataStreamController.close();
  }
}