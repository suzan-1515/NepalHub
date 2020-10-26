import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

extension NewsFeedX on NewsFeedEntity {
  NewsFeedUIModel get toUIModel => NewsFeedUIModel(feed: this);
}

extension NewsFeedListX on List<NewsFeedEntity> {
  List<NewsFeedUIModel> get toUIModels => this.map((e) => e.toUIModel).toList();
}

extension NewsCategoryX on NewsCategoryEntity {
  NewsCategoryUIModel get toUIModel => NewsCategoryUIModel(category: this);
}

extension NewsCategoryListX on List<NewsCategoryEntity> {
  List<NewsCategoryUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}

extension NewsSourceX on NewsSourceEntity {
  NewsSourceUIModel get toUIModel => NewsSourceUIModel(source: this);
}

extension NewsSourceListX on List<NewsSourceEntity> {
  List<NewsSourceUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}

extension NewsTopicX on NewsTopicEntity {
  NewsTopicUIModel get toUIModel => NewsTopicUIModel(topic: this);
}

extension NewsTopicListX on List<NewsTopicEntity> {
  List<NewsTopicUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}
