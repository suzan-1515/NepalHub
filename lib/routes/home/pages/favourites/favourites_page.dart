import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/routes/home/pages/favourites/logic/favourites_store.dart';
import 'package:samachar_hub/routes/home/widgets/news_list_view.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Provider.of<FavouritesStore>(context, listen: false).loadInitialFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child:
                Text('Favourites', style: Theme.of(context).textTheme.headline),
          ),
          Expanded(
            child: Consumer<FavouritesStore>(
                builder: (context, favouriteStore, child) {
              return Observer(builder: (_) {
                switch (favouriteStore.loadFeedItemsFuture.status) {
                  case FutureStatus.pending:
                    return Center(
                      // Todo: Replace with Shimmer
                      child: CircularProgressIndicator(),
                    );
                  case FutureStatus.rejected:
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Oops something went wrong'),
                          RaisedButton(
                            child: Text('Retry'),
                            onPressed: () {
                              favouriteStore.retry();
                            },
                          ),
                        ],
                      ),
                    );
                  case FutureStatus.fulfilled:
                    final List<Feed> newsData = favouriteStore.feedData;
                    if (null != newsData && newsData.isNotEmpty) {
                      return RefreshIndicator(
                        child: IncrementallyLoadingListView(
                            hasMore: () => favouriteStore.hasMoreData,
                            itemCount: () => newsData.length,
                            loadMore: () async {
                              await favouriteStore.loadMoreData();
                            },
                            loadMoreOffsetFromBottom: 2,
                            itemBuilder: (BuildContext context, int index) {
                              final article = newsData[index];
                              if (index == newsData.length - 1 &&
                                  favouriteStore.hasMoreData &&
                                  !favouriteStore.isLoadingMore) {
                                return Column(
                                  children: <Widget>[
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => favouriteStore.onFeedClick(
                                            article, context),
                                        child: NewsListView(article),
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
                                    onTap: () => favouriteStore.onFeedClick(
                                        article, context),
                                    child: NewsListView(article),
                                  ),
                                );
                              }
                            }),
                        onRefresh: () async {favouriteStore.refresh();},
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Empty Data!'),
                          RaisedButton(
                              child: Text('Retry'),
                              onPressed: () async {
                                favouriteStore.retry();
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
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
