import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/repository/following_repository.dart';

part 'following_store.g.dart';

class FollowingStore = _FollowingStore with _$FollowingStore;

abstract class _FollowingStore with Store {
  final FollowingRepository _favouritesRepository;
  final NewsRepository _newsRepository;

  _FollowingStore(
    this._favouritesRepository,
    this._newsRepository,
  );

  StreamController<List<NewsSourceModel>> _newsSourceStreamController =
      StreamController<List<NewsSourceModel>>.broadcast();
  StreamController<List<NewsCategoryModel>> _newsCategoryStreamController =
      StreamController<List<NewsCategoryModel>>.broadcast();
  StreamController<NewsTopicModel> _newsTopicStreamController =
      StreamController<NewsTopicModel>.broadcast();

  Stream<List<NewsSourceModel>> get newsSourceFeedStream =>
      _newsSourceStreamController.stream;
  Stream<List<NewsCategoryModel>> get newsCategoryFeedStream =>
      _newsCategoryStreamController.stream;
  Stream<NewsTopicModel> get newsTopicFeedStream =>
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
    return _newsRepository.getSources().then((value) {
      if (value != null) {
        _newsSourceStreamController
            .add(value.where((element) => element.isFollowed).toList());
      } else
        _newsSourceStreamController.add(List<NewsSourceModel>());
    }).catchError((onError) {
      _newsSourceStreamController.addError(onError);
    });
  }

  @action
  Future<void> loadFollowedNewsCategoryData() {
    _newsCategoryStreamController.add(null);
    return _newsRepository.getCategories().then((value) {
      if (value != null) {
        _newsCategoryStreamController
            .add(value.where((element) => element.isFollowed).toList());
      } else
        _newsCategoryStreamController.add(List<NewsCategoryModel>());
    }).catchError((onError) {
      _newsCategoryStreamController.addError(onError);
    });
  }

  @action
  Future<void> loadFollowedNewsTopicData() {
    return _favouritesRepository.getFollowedTopics().then((value) {
      if (value != null) {
        _newsTopicStreamController.add(value);
      }
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
