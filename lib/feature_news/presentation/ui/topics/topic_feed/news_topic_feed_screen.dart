import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/widgets/news_topic_feed_header.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/widgets/news_topic_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsTopicFeedScreen extends StatelessWidget {
  final NewsTopicEntity newsTopicEntity;
  const NewsTopicFeedScreen({Key key, @required this.newsTopicEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.topicFeedBlocProvider(
      topic: newsTopicEntity,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: NewsFilteringAppBar(
            header: const NewsTopicFeedHeader(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const NewsTopicFeedList(),
            ),
          ),
        ),
      ),
    );
  }
}
