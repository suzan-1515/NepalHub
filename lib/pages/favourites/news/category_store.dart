import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';

part 'category_store.g.dart';

class FavouriteNewsCategoryStore = _FavouriteNewsCategoryStore
    with _$FavouriteNewsCategoryStore;

abstract class _FavouriteNewsCategoryStore with Store {
  final NewsRepository _newsRepository;

  _FavouriteNewsCategoryStore(this._newsRepository);

  StreamController<List<NewsCategoryModel>> _dataStreamController =
      StreamController<List<NewsCategoryModel>>.broadcast();

  Stream<List<NewsCategoryModel>> get dataStream =>
      _dataStreamController.stream;
  List<NewsCategoryModel> data = List<NewsCategoryModel>();

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
    data.clear();
    _loadCategoryData();
  }

  Future _loadCategoryData() async {
    return _newsRepository.getCategories().then((onValue) {
      if (onValue != null) {
        data.addAll(onValue);
      }
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
      _dataStreamController.addError(error);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
      _dataStreamController.addError(error);
    });
  }

  dispose() {
    _dataStreamController.close();
  }
}
