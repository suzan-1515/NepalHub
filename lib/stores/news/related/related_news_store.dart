import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'related_news_store.g.dart';

class RelatedNewsStore = _RelatedNewsStore with _$RelatedNewsStore;

abstract class _RelatedNewsStore with Store {
  final NewsRepository _newsRepository;
  final NewsFeed _newsFeed;

  StreamController<List<NewsFeed>> _dataStreamController =
      StreamController<List<NewsFeed>>.broadcast();

  Stream<List<NewsFeed>> get dataStream => _dataStreamController.stream;

  List<NewsFeed> data = List<NewsFeed>();
  bool _isLoadingMore = false;
  bool _hasMoreData = false;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;
  NewsFeed get parentFeed => _newsFeed;

  _RelatedNewsStore(this._newsRepository, this._newsFeed);

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  Future<void> refresh() async {
    return _loadRelatedNews();
  }

  @action
  void retry() {
    _loadRelatedNews();
  }

  @action
  loadInitialData() {
    _loadRelatedNews();
  }

  Future<void> _loadRelatedNews() async {
    if (parentFeed.related == null || parentFeed.related.isEmpty)
      return _dataStreamController.add(null);

    _dataStreamController.add(parentFeed.related);
  }

  dispose() {
    _dataStreamController.close();
  }
}
