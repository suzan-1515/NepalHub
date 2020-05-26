import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'trending_news_store.g.dart';

class TrendingNewsStore = _TrendingNewsStore with _$TrendingNewsStore;

abstract class _TrendingNewsStore with Store {
  final NewsRepository _newsRepository;
  final PreferenceService _preferenceService;

  StreamController<List<Feed>> _dataStreamController =
      StreamController<List<Feed>>.broadcast();

  Stream<List<Feed>> get dataStream => _dataStreamController.stream;

  List<Feed> data = List<Feed>();

  _TrendingNewsStore(this._preferenceService, this._newsRepository);

  @observable
  int currentNewsCarousel = 0;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  Future<void> refresh() async {
    return _loadData();
  }

  @action
  loadPreviewData() {
    _loadData(limit: '5');
  }

  @action
  loadFullData() {
    _loadData();
  }

  Future<void> _loadData({String limit}) {
    return _newsRepository.getTrendingFeeds(limit: limit).then((onValue) {
      if (onValue != null) {
        data.clear();
        data.addAll(onValue);
      }
      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
    }, test: (e) => e is APIException).catchError(
        (onError) => this.error = onError.toString());
  }

  dispose() {
    _dataStreamController.close();
  }
}
