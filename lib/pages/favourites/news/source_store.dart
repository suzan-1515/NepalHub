import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/repository/favourites_repository.dart';

part 'source_store.g.dart';

class FavouriteNewsSourceStore = _FavouriteNewsSourceStore
    with _$FavouriteNewsSourceStore;

abstract class _FavouriteNewsSourceStore with Store {
  final NewsRepository _newsRepository;
  final FavouritesRepository _favouritesRepository;

  _FavouriteNewsSourceStore(this._newsRepository, this._favouritesRepository);

  StreamController<List<NewsSourceModel>> _dataStreamController =
      StreamController<List<NewsSourceModel>>.broadcast();

  Stream<List<NewsSourceModel>> get dataStream => _dataStreamController.stream;
  List<NewsSourceModel> data = List<NewsSourceModel>();

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  void loadInitialData() {
    _loadSourceData();
  }

  @action
  void retry() {
    data.clear();
    _loadSourceData();
  }

  Future _loadSourceData() async {
    return _newsRepository.getSources().then((onValue) {
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

  Future updateFollowedNewsSources() {
    return _favouritesRepository.unFollowSources(
        data.where((element) => !element.enabled.value).toList());
  }

  dispose() {
    _dataStreamController.close();
  }
}
