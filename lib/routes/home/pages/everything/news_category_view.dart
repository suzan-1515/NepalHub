import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api.dart';
import 'package:samachar_hub/data/model/news.dart';
import 'package:samachar_hub/routes/home/pages/everything/logic/everything_store.dart';
import 'package:samachar_hub/routes/home/pages/pages.dart';
import 'package:samachar_hub/routes/home/widgets/news_compact_view.dart';
import 'package:samachar_hub/routes/home/widgets/news_list_view.dart';
import 'package:samachar_hub/routes/home/widgets/news_thumbnail_view.dart';

class NewsCategoryView extends StatelessWidget {
  final NewsCategory category;

  NewsCategoryView(this.category);

  @override
  Widget build(BuildContext context) {
    return Consumer<EverythingStore>(
      builder: (context, everythingStore, child) {
        return Observer(builder: (_) {
          if (everythingStore.loadingStatus[category] ?? true) {
            return Center(
              // Todo: Replace with Shimmer
              child: CircularProgressIndicator(),
            );
          }
          final News topHeadlines =
              everythingStore.newsData[category];
          if (null != topHeadlines && topHeadlines.feeds.isNotEmpty) {
            final MenuItem viewType = everythingStore.view;
            return ListView.builder(
                itemCount: topHeadlines.feeds.length,
                itemBuilder: (BuildContext context, int position) {
                  Widget articleWidget;
                  final article = topHeadlines.feeds[position];
                  switch (viewType) {
                    case MenuItem.LIST_VIEW:
                      articleWidget = NewsListView(article);
                      break;
                    case MenuItem.THUMBNAIL_VIEW:
                      articleWidget = NewsThumbnailView(article);
                      break;
                    case MenuItem.COMPACT_VIEW:
                      articleWidget = NewsCompactView(article);
                      break;
                  }
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          everythingStore.onFeedClick(article, context),
                      child: articleWidget,
                    ),
                  );
                });
          } else
            return Center(child: Text('Error!'));
        });
      },
    );
  }
}
