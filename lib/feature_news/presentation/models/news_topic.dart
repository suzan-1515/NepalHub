import 'package:flutter/cupertino.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsTopicUIModel extends Model {
  NewsTopicEntity topicUIModel;

  NewsTopicUIModel({@required this.topicUIModel});

  set entity(NewsTopicEntity categoryEntity) {
    this.topicUIModel = categoryEntity;
    notifyListeners();
  }

  NewsTopicEntity get entity => this.topicUIModel;

  unFollow() => this.entity = this.entity.copyWith(
      isFollowed: false, followerCount: this.entity.followerCount - 1);
  follow() => this.entity = this
      .entity
      .copyWith(isFollowed: true, followerCount: this.entity.followerCount + 1);
}
