import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'following_store.g.dart';

class FollowingStore = _FollowingStore with _$FollowingStore;

abstract class _FollowingStore with Store {
  final NewsRepository _newsRepository;

  _FollowingStore(
    this._newsRepository,
  );

  StreamController<List<NewsSource>> _newsSourceStreamController =
      StreamController<List<NewsSource>>.broadcast();
  StreamController<List<NewsCategory>> _newsCategoryStreamController =
      StreamController<List<NewsCategory>>.broadcast();
  StreamController<List<NewsTopic>> _newsTopicStreamController =
      StreamController<List<NewsTopic>>.broadcast();

  Stream<List<NewsSource>> get newsSourceFeedStream =>
      _newsSourceStreamController.stream;
  Stream<List<NewsCategory>> get newsCategoryFeedStream =>
      _newsCategoryStreamController.stream;
  Stream<List<NewsTopic>> get newsTopicFeedStream =>
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
        _newsSourceStreamController.add(List<NewsSource>());
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
        _newsCategoryStreamController.add(List<NewsCategory>());
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
        _newsTopicStreamController.add(List<NewsTopic>());
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
