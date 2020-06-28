import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';

part 'news_topic_store.g.dart';

class NewsTopicStore = _NewsTopicStore with _$NewsTopicStore;

abstract class _NewsTopicStore with Store {
  final NewsRepository _newsRepository;

  _NewsTopicStore(this._newsRepository);

  StreamController<List<NewsFeedModel>> _newsDataStreamController =
      StreamController<List<NewsFeedModel>>.broadcast();
  Stream<List<NewsFeedModel>> get newsDataStream => _newsDataStreamController.stream;

  StreamController<NewsTopicModel> _topicsDataStreamController =
      StreamController<NewsTopicModel>.broadcast();
  Stream<NewsTopicModel> get topicsDataStream => _topicsDataStreamController.stream;

  List<NewsFeedModel> topicNewsdata = List<NewsFeedModel>();
  NewsTopicModel topicData;

  @observable
  String selectedTopic;

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  setSelectedTopic(String topic) {
    this.selectedTopic = topic;
    this.topicNewsdata.clear();
    _newsDataStreamController.add(null);
    _loadTopicNewsData();
  }

  @action
  void loadTopics() {
    _loadTopics();
  }

  @action
  void loadTopicNews() {
    _loadTopicNewsData();
  }

  @action
  void retryTopics() {
    topicData = null;
    _loadTopics();
  }

  @action
  void retryTopicNews() {
    topicNewsdata.clear();
    _loadTopicNewsData();
  }

  Future _loadTopicNewsData() async {
    return _newsRepository.getNewsByTopic(tag: selectedTopic).then((onValue) {
      if (onValue != null) {
        topicNewsdata.addAll(onValue);
      }
      _newsDataStreamController.add(topicNewsdata);
    }).catchError((onError) {
      this.apiError = onError;
      _newsDataStreamController.addError(error);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
      _newsDataStreamController.addError(error);
    });
  }

  Future _loadTopics() async {
    return _newsRepository
        .getTopics()
        .then((onValue) {
          topicData = onValue;
          _topicsDataStreamController.add(topicData);
        })
        .catchError((onError) {}, test: (e) => e is APIException)
        .catchError((onError) {});
  }

  dispose() {
    _newsDataStreamController.close();
    _topicsDataStreamController.close();
  }
}
