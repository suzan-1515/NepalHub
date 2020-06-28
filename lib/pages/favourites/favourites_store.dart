import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/favourites_repository.dart';

part 'favourites_store.g.dart';

class FavouritesStore = _FavouritesStore with _$FavouritesStore;

abstract class _FavouritesStore with Store {
  final FavouritesRepository _favouritesRepository;

  _FavouritesStore(
    this._favouritesRepository,
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
  Future<void> loadFollowedNewsSourceData() {
    return _favouritesRepository.getFollowedSources().then((value) {
      if (value != null) {
        _newsSourceStreamController.add(value);
      }
    }).catchError((onError) {
      _newsSourceStreamController.addError(onError);
    });
  }

  @action
  Future<void> loadFollowedNewsCategoryData() {
    return _favouritesRepository.getFollowedCategories().then((value) {
      if (value != null) {
        _newsCategoryStreamController.add(value);
      }
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
