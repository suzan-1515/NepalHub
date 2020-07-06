import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/repository/favourites_repository.dart';

part 'favourites_store.g.dart';

class FavouritesStore = _FavouritesStore with _$FavouritesStore;

abstract class _FavouritesStore with Store {
  final FavouritesRepository _favouritesRepository;
  final NewsRepository _newsRepository;

  _FavouritesStore(
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

  List<NewsSourceModel> sourceData = List<NewsSourceModel>();
  List<NewsCategoryModel> categoryData = List<NewsCategoryModel>();

  @observable
  String error;

  @observable
  String message;

  @action
  retryNewsSources() {
    sourceData.clear();
    loadFollowedNewsSourceData();
  }

  @action
  retryNewsCategory() {
    categoryData.clear();
    loadFollowedNewsCategoryData();
  }

  @action
  retryNewsTopic() {
    loadFollowedNewsTopicData();
  }

  @action
  Future<void> loadFollowedNewsSourceData() {
    if (sourceData.isNotEmpty) return Future.value();
    _newsSourceStreamController.add(null);
    return _newsRepository.getSources().then((value) {
      if (value != null) {
        sourceData
            .addAll(value.where((element) => element.enabled.value).toList());
        _newsSourceStreamController.add(sourceData);
      }
    }).catchError((onError) {
      _newsSourceStreamController.addError(onError);
    });
  }

  @action
  Future<void> loadFollowedNewsCategoryData() {
    if (categoryData.isNotEmpty) return Future.value();
    _newsCategoryStreamController.add(null);
    return _newsRepository.getCategories().then((value) {
      if (value != null) {
        categoryData
            .addAll(value.where((element) => element.enabled.value).toList());
        _newsCategoryStreamController.add(categoryData);
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
