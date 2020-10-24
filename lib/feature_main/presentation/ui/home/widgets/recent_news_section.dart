import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/recent_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class RecentNewsSection extends StatelessWidget {
  final RecentNewsUIModel recentNewsUIModel;
  const RecentNewsSection({Key key, @required this.recentNewsUIModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, int index) {
        if (index == 0) {
          return SectionHeading(
            title: 'Recent News',
            subtitle: 'Most recent stories around you',
          );
        }
        var feed = recentNewsUIModel.feeds[index - 1];
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
      }, childCount: recentNewsUIModel.feeds.length + 1),
    );
  }
}
