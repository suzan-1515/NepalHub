import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/repository/following_repository.dart';

part 'category_store.g.dart';

class FollowNewsCategoryStore = _FollowNewsCategoryStore
    with _$FollowNewsCategoryStore;

abstract class _FollowNewsCategoryStore with Store {
  final NewsRepository _newsRepository;
  final FollowingRepository _favouritesRepository;

  _FollowNewsCategoryStore(this._newsRepository, this._favouritesRepository);

  StreamController<List<NewsCategory>> _dataStreamController =
      StreamController<List<NewsCategory>>.broadcast();

  Stream<List<NewsCategory>> get dataStream => _dataStreamController.stream;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  void loadInitialData() {
    _loadCategoryData();
  }

  @action
  void retry() {
    _loadCategoryData();
  }

  @action
  Future refresh() {
    return _loadCategoryData();
  }

  Future _loadCategoryData() async {
    return _newsRepository.getCategories().then((onValue) {
      _dataStreamController.add(onValue);
    }).catchError((onError) {
      this.apiError = onError;
      _dataStreamController.addError(error);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
      _dataStreamController.addError(error);
    });
  }

  @action
  Future<void> followedNewsCategory(NewsCategory categoryModel) {
    return _favouritesRepository.followCategory(categoryModel);
  }

  @action
  Future<void> unFollowedNewsCategory(NewsCategory categoryModel) {
    return _favouritesRepository.unFollowCategory(categoryModel);
  }

  dispose() {
    _dataStreamController.close();
  }
}
