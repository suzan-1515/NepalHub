import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:mobx/mobx.dart';
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
        switch (everythingStore.loadFeedItemsFuture[category]?.status) {
          case FutureStatus.pending:
            return Center(
              // Todo: Replace with Shimmer
              child: CircularProgressIndicator(),
            );
          case FutureStatus.rejected:
          print('rejected');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Oops something went wrong'),
                  RaisedButton(
                    child: Text('Retry'),
                    onPressed: () {
                      everythingStore.retry(category);
                    },
                  ),
                ],
              ),
            );
          case FutureStatus.fulfilled:
            final News newsData = everythingStore.newsData[category];
            if (null != newsData && newsData.feeds.isNotEmpty) {
              final MenuItem viewType = everythingStore.view;
              return RefreshIndicator(
                child: IncrementallyLoadingListView(
                    hasMore: () =>
                        everythingStore.hasMoreData[category] ?? true,
                    itemCount: () => newsData.feeds.length,
                    loadMore: () async {
                      await everythingStore.loadMoreData(category);
                    },
                    loadMoreOffsetFromBottom: 2,
                    itemBuilder: (BuildContext context, int index) {
                      final feed = newsData.feeds[index];
                      Widget articleWidget;
                      switch (viewType) {
                        case MenuItem.LIST_VIEW:
                          articleWidget = NewsListView(feed);
                          break;
                        case MenuItem.THUMBNAIL_VIEW:
                          articleWidget = NewsThumbnailView(feed);
                          break;
                        case MenuItem.COMPACT_VIEW:
                          articleWidget = NewsCompactView(feed);
                          break;
                      }
                      if (index == newsData.feeds.length - 1 &&
                          everythingStore.hasMoreData[category] ?? true &&
                          !everythingStore.isLoadingMore[category] ?? false) {
                        return Column(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () =>
                                    everythingStore.onFeedClick(feed, context),
                                child: articleWidget,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      } else {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () =>
                                everythingStore.onFeedClick(feed, context),
                            child: articleWidget,
                          ),
                        );
                      }
                    }),
                onRefresh: () async {
                  await everythingStore.refresh(category);
                },
              );
            }
            return Center(
              child: Column(
                children: <Widget>[
                  Text('Empty Data!'),
                  RaisedButton(
                      child: Text('Retry'),
                      onPressed: () async {
                        everythingStore.retry(category);
                      }),
                ],
              ),
            );
          default:
            return Center(
              // Todo: Replace with Shimmer
              child: CircularProgressIndicator(),
            );
        }
      });
    });
  }
}
