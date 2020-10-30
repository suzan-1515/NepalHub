import 'package:flutter/material.dart';
import 'package:samachar_hub/core/view/content_view_style.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_compact_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsListBuilder extends StatelessWidget {
  const NewsListBuilder({
    Key key,
    @required this.onRefresh,
    @required this.data,
    this.hasMore = false,
    this.contentViewStyle = ContentViewStyle.LIST_VIEW,
    this.onLoadMore,
  })  : assert(onRefresh != null, 'Refresh callback function cannot be null'),
        assert(data != null, 'News feeds cannot be null'),
        super(key: key);

  final Future<void> Function() onRefresh;
  final Function() onLoadMore;
  final List<NewsFeedUIModel> data;
  final bool hasMore;
  final ContentViewStyle contentViewStyle;

  bool _shouldShowLoadMore(index) => hasMore && (index == data.length);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: hasMore ? data.length + 1 : data.length,
        itemBuilder: (_, int index) {
          if (_shouldShowLoadMore(index)) {
            onLoadMore();
            return Center(
              child: ProgressView(),
            );
          }

          var feed = data[index];
          var view;
          switch (contentViewStyle) {
            case ContentViewStyle.LIST_VIEW:
              view = NewsListView(
                feedUIModel: feed,
              );
              break;
            case ContentViewStyle.THUMBNAIL_VIEW:
              view = NewsThumbnailView(
                feedUIModel: feed,
              );
              break;
            case ContentViewStyle.COMPACT_VIEW:
              view = NewsCompactView(
                feedUIModel: feed,
              );
              break;
          }
          return NewsProvider.feedItemBlocProvider(
            feedUIModel: feed,
            child: view,
          );
        },
      ),
    );
  }
}
