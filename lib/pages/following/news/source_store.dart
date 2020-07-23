import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/repository/following_repository.dart';

part 'source_store.g.dart';

class FollowNewsSourceStore = _FollowNewsSourceStore
    with _$FollowNewsSourceStore;

abstract class _FollowNewsSourceStore with Store {
  final NewsRepository _newsRepository;
  final FollowingRepository _favouritesRepository;

  _FollowNewsSourceStore(this._newsRepository, this._favouritesRepository);

  StreamController<List<NewsSource>> _dataStreamController =
      StreamController<List<NewsSource>>.broadcast();

  Stream<List<NewsSource>> get dataStream => _dataStreamController.stream;

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
    _loadSourceData();
  }

  @action
  Future refresh() {
    return _loadSourceData();
  }

  Future _loadSourceData() async {
    return _newsRepository.getSources().then((onValue) {
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
  Future<void> followedNewsSource(NewsSource sourceModel) {
    return _favouritesRepository.followSource(sourceModel);
  }

  @action
  Future<void> unFollowedNewsSource(NewsSource sourceModel) {
    return _favouritesRepository.unFollowSource(sourceModel);
  }

  dispose() {
    _dataStreamController.close();
  }
}
