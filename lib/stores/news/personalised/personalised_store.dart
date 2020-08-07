import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/utils/content_view_type.dart';

part 'personalised_store.g.dart';

class PersonalisedNewsStore = _PersonalisedNewsStore
    with _$PersonalisedNewsStore;

abstract class _PersonalisedNewsStore with Store {
  final NewsRepository _newsRepository;

  StreamController<List<NewsFeed>> _dataStreamController =
      StreamController<List<NewsFeed>>.broadcast();

  Stream<List<NewsFeed>> get dataStream => _dataStreamController.stream;

  _PersonalisedNewsStore(this._newsRepository);

  List<NewsFeed> _data = List<NewsFeed>();

  bool _isLoading = false;
  bool _hasMore = false;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  @observable
  APIException apiError;

  @observable
  String error;

  @observable
  ContentViewStyle view = ContentViewStyle.THUMBNAIL_VIEW;

  @action
  void loadInitialData() {
    _loadFirstPageData();
  }

  @action
  Future<void> refresh() async {
    return _loadFirstPageData();
  }

  @action
  void retry() {
    _loadFirstPageData();
  }

  @action
  setView(ContentViewStyle value) {
    view = value;
  }

  @action
  Future _loadFirstPageData() async {
    if (isLoading) return;
    _isLoading = true;
    _dataStreamController.add(null);
    _data.clear();
    return _newsRepository.getLatestFeeds().then((onValue) {
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
    if (isLoading || !hasMore) return;
    _isLoading = true;
    return _newsRepository.getLatestFeeds().then((onValue) {
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
