import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/repository/news_repository.dart';

part 'topic_news_store.g.dart';

class TopicNewsStore = _TopicNewsStore with _$TopicNewsStore;

abstract class _TopicNewsStore with Store {
  final NewsRepository _newsRepository;

  _TopicNewsStore(this._newsRepository);

  StreamController<List<Feed>> _newsDataStreamController =
      StreamController<List<Feed>>.broadcast();
  Stream<List<Feed>> get newsDataStream => _newsDataStreamController.stream;

  StreamController<NewsTopics> _topicsDataStreamController =
      StreamController<NewsTopics>.broadcast();
  Stream<NewsTopics> get topicsDataStream => _topicsDataStreamController.stream;

  List<Feed> topicNewsdata = List<Feed>();
  NewsTopics topicData;

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
