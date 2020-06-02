import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/category/categories_page.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_compact_view.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';

class NewsCategoryView extends StatelessWidget {
  final NewsCategory category;

  NewsCategoryView(this.category);

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoriesStore, NavigationService>(
        builder: (context, categoriesStore, _navigationService, child) {
      return Observer(builder: (_) {
        switch (categoriesStore.loadFeedItemsFuture[category]?.status) {
          case FutureStatus.pending:
            return Center(
              // Todo: Replace with Shimmer
              child: ProgressView(),
            );
          case FutureStatus.rejected:
            return Center(
              child: ErrorDataView(
                onRetry: () => categoriesStore.retry(category),
              ),
            );
          case FutureStatus.fulfilled:
            final List<NewsFeedModel> newsData =
                categoriesStore.newsData[category];
            if (null != newsData && newsData.isNotEmpty) {
              final MenuItem viewType = categoriesStore.view;
              return RefreshIndicator(
                child: IncrementallyLoadingListView(
                    hasMore: () =>
                        categoriesStore.hasMoreData[category] ?? true,
                    itemCount: () => newsData.length,
                    loadMore: () async {
                      await categoriesStore.loadMoreData(category);
                    },
                    loadMoreOffsetFromBottom: 2,
                    itemBuilder: (BuildContext context, int index) {
                      final feed = newsData[index];
                      Widget articleWidget;
                      switch (viewType) {
                        case MenuItem.LIST_VIEW:
                          articleWidget = NewsListView(feed: feed);
                          break;
                        case MenuItem.THUMBNAIL_VIEW:
                          articleWidget = NewsThumbnailView(feed);
                          break;
                        case MenuItem.COMPACT_VIEW:
                          articleWidget = AspectRatio(
                              aspectRatio: 16 / 9,
                              child: NewsCompactView(feed));
                          break;
                      }
                      if (index == newsData.length - 1 &&
                              categoriesStore.hasMoreData[category] ??
                          true && !categoriesStore.isLoadingMore[category] ??
                          false) {
                        return Column(
                          children: <Widget>[
                            articleWidget,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      } else {
                        return articleWidget;
                      }
                    }),
                onRefresh: () async {
                  await categoriesStore.refresh(category);
                },
              );
            }
            return Center(child: EmptyDataView());
          default:
            return Center(
              // Todo: Replace with Shimmer
              child: ProgressView(),
            );
        }
      });
    });
  }
}
