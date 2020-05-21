import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'news_source_store.g.dart';

class NewsSourceStore = _NewsSourceStore with _$NewsSourceStore;

abstract class _NewsSourceStore with Store {
  final NewsRepository _newsRepository;

  _NewsSourceStore(this._newsRepository);

  StreamController<List<FeedSource>> _dataStreamController =
      StreamController<List<FeedSource>>.broadcast();

  Stream<List<FeedSource>> get dataStream => _dataStreamController.stream;
  List<FeedSource> data = List<FeedSource>();

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

  dispose(){
    _dataStreamController.close();
  }
}
