import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api.dart';
import 'package:samachar_hub/data/model/top_headlines.dart';
import 'package:samachar_hub/routes/home/pages/topheadlines/logic/top_headlines_store.dart';
import 'package:samachar_hub/routes/home/pages/topheadlines/top_headlines_page.dart';
import 'package:samachar_hub/routes/home/widgets/news_compact_view.dart';
import 'package:samachar_hub/routes/home/widgets/news_list_view.dart';
import 'package:samachar_hub/routes/home/widgets/news_thumbnail_view.dart';

class TopHeadlinesCategoryView extends StatelessWidget {
  final NewsCategory category;

  TopHeadlinesCategoryView(this.category);

  @override
  Widget build(BuildContext context) {
    return Consumer<TopHeadlinesStore>(
      builder: (context, topHeadlinesStore, child) {
        return Observer(builder: (_) {
          if (topHeadlinesStore.loadingStatus[category] ?? true) {
            return Center(
              // Todo: Replace with Shimmer
              child: CircularProgressIndicator(),
            );
          }
          final TopHeadlines topHeadlines =
              topHeadlinesStore.newsData[category];
          if (null != topHeadlines && topHeadlines.articles.isNotEmpty) {
            final MenuItem viewType = topHeadlinesStore.view;
            return ListView.builder(
                itemCount: topHeadlines.articles.length,
                itemBuilder: (BuildContext context, int position) {
                  Widget articleWidget;
                  final article = topHeadlines.articles[position];
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
                          topHeadlinesStore.onArticleClick(article, context),
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
