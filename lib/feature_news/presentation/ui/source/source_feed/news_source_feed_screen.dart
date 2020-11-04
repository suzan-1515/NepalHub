import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/widgets/news_source_feed_header.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/widgets/news_source_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsSourceFeedScreen extends StatelessWidget {
  final NewsSourceEntity newsSourceEntity;
  const NewsSourceFeedScreen({Key key, @required this.newsSourceEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.sourceFeedBlocProvider(
      source: newsSourceEntity,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: NewsFilteringAppBar(
            header: const NewsSourceFeedHeader(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewsSourceFeedList(),
            ),
          ),
        ),
      ),
    );
  }
}
