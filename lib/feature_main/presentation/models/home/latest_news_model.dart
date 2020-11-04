import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';

class LatestNewsUIModel {
  List<NewsFeedEntity> feeds;
  LatestNewsUIModel({@required this.feeds});
}
