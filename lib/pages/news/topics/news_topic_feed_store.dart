import 'dart:async';
import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/domain/sort.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';

part 'news_topic_feed_store.g.dart';

class NewsTopicFeedStore = _NewsTopicFeedStore with _$NewsTopicFeedStore;

abstract class _NewsTopicFeedStore with Store {
  final NewsRepository _newsRepository;
  final NewsTopicModel _topicModel;

  _NewsTopicFeedStore(this._newsRepository, this._topicModel);

  StreamController<List<NewsFeedModel>> _dataStreamController =
      StreamController<List<NewsFeedModel>>.broadcast();
  Stream<List<NewsFeedModel>> get dataStream => _dataStreamController.stream;

  @observable
  ObservableList<NewsSourceModel> sources = ObservableList();

  List<NewsFeedModel> _data = List<NewsFeedModel>();

  bool _isLoading = false;
  bool _hasMore = false;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  NewsTopicModel get topic => _topicModel;

  @observable
  SortBy sort = SortBy.RELEVANCE;

  @observable
  NewsSourceModel selectedSource;

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
        .getNewsByTopic(
      topic: topic.tag,
      source: selectedSource?.code,
      sort: sort,
    )
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
        .getNewsByTopic(
      topic: topic.tag,
      source: selectedSource?.code,
      sort: sort,
    )
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
  setSource(NewsSourceModel source) {
    this.selectedSource = source;
    refresh();
  }

  dispose() {
    _dataStreamController.close();
  }
}
