import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';

class RecentNewsUIModel {
  List<NewsFeedEntity> feeds;
  RecentNewsUIModel({@required this.feeds});
}
