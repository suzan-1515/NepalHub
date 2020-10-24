import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class LatestNewsSection extends StatelessWidget {
  final LatestNewsUIModel latestNewsUIModel;
  const LatestNewsSection({Key key, @required this.latestNewsUIModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, int index) {
        if (index == 0) {
          return SectionHeading(
            title: 'Latest News',
            subtitle: 'Latest stories around you',
          );
        }
        var feed = latestNewsUIModel.feeds[index - 1];
        Widget feedWidget;
        if (index % 4 == 0) {
          feedWidget = NewsThumbnailView(
            feedUIModel: feed,
          );
        } else {
          feedWidget = NewsListView(
            feedUIModel: feed,
          );
        }
        return NewsProvider.feedItemBlocProvider(
          feedUIModel: feed,
          child: feedWidget,
        );
      }, childCount: latestNewsUIModel.feeds.length + 1),
    );
  }
}
