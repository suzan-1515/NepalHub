import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

extension NewsFeedEntityX on NewsFeedEntity {
  NewsFeedUIModel get toUIModel => NewsFeedUIModel(this);
}

extension NewsFeedEntityListX on List<NewsFeedEntity> {
  List<NewsFeedUIModel> get toUIModels => this.map((e) => e.toUIModel).toList();
}

extension NewsCategoryEntityX on NewsCategoryEntity {
  NewsCategoryUIModel get toUIModel => NewsCategoryUIModel(this);
}

extension NewsCategoryEntityListX on List<NewsCategoryEntity> {
  List<NewsCategoryUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}

extension NewsSourceEntityX on NewsSourceEntity {
  NewsSourceUIModel get toUIModel => NewsSourceUIModel(this);
}

extension NewsSourceEntityListX on List<NewsSourceEntity> {
  List<NewsSourceUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}

extension NewsTopicEntityX on NewsTopicEntity {
  NewsTopicUIModel get toUIModel => NewsTopicUIModel(topicUIModel: this);
}

extension NewsTopicEntityListX on List<NewsTopicEntity> {
  List<NewsTopicUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}
