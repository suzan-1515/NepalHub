import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';

part 'following_store.g.dart';

class FollowingStore = _FollowingStore with _$FollowingStore;

abstract class _FollowingStore with Store {
  final NewsRepository _newsRepository;

  _FollowingStore(
    this._newsRepository,
  );

  StreamController<List<NewsSourceModel>> _newsSourceStreamController =
      StreamController<List<NewsSourceModel>>.broadcast();
  StreamController<List<NewsCategoryModel>> _newsCategoryStreamController =
      StreamController<List<NewsCategoryModel>>.broadcast();
  StreamController<List<NewsTopicModel>> _newsTopicStreamController =
      StreamController<List<NewsTopicModel>>.broadcast();

  Stream<List<NewsSourceModel>> get newsSourceFeedStream =>
      _newsSourceStreamController.stream;
  Stream<List<NewsCategoryModel>> get newsCategoryFeedStream =>
      _newsCategoryStreamController.stream;
  Stream<List<NewsTopicModel>> get newsTopicFeedStream =>
      _newsTopicStreamController.stream;

  @observable
  String error;

  @observable
  String message;

  @action
  retryNewsSources() {
    loadFollowedNewsSourceData();
  }

  @action
  retryNewsCategory() {
    loadFollowedNewsCategoryData();
  }

  @action
  retryNewsTopic() {
    loadFollowedNewsTopicData();
  }

  @action
  Future refresh() async {
    await loadFollowedNewsSourceData();
    await loadFollowedNewsSourceData();
    await loadFollowedNewsTopicData();
  }

  @action
  Future<void> loadFollowedNewsSourceData() {
    return _newsRepository.getSources(followedOnly: true).then((value) {
      if (value != null) {
        _newsSourceStreamController.add(value);
      } else
        _newsSourceStreamController.add(List<NewsSourceModel>());
    }).catchError((onError) {
      _newsSourceStreamController.addError(onError);
    });
  }

  @action
  Future<void> loadFollowedNewsCategoryData() {
    _newsCategoryStreamController.add(null);
    return _newsRepository.getCategories(followedOnly: true).then((value) {
      if (value != null) {
        _newsCategoryStreamController.add(value);
      } else
        _newsCategoryStreamController.add(List<NewsCategoryModel>());
    }).catchError((onError) {
      _newsCategoryStreamController.addError(onError);
    });
  }

  @action
  Future<void> loadFollowedNewsTopicData() {
    return _newsRepository.getTopics(followedOnly: true).then((value) {
      if (value != null) {
        _newsTopicStreamController.add(value);
      } else
        _newsTopicStreamController.add(List<NewsTopicModel>());
    }).catchError((onError) {
      _newsTopicStreamController.addError(onError);
    });
  }

  dispose() {
    _newsSourceStreamController.close();
    _newsCategoryStreamController.close();
    _newsTopicStreamController.close();
  }
}
