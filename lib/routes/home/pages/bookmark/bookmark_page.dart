import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/routes/home/pages/bookmark/bookmark_list_item.dart';
import 'package:samachar_hub/store/bookmark_store.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage>
    with AutomaticKeepAliveClientMixin {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<BookmarkStore>(context, listen: false);
    _setupObserver(store);
    store.loadInitialData();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
    ];
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
                Text('Bookmarks', style: Theme.of(context).textTheme.headline),
          ),
          Expanded(
            child: Consumer<BookmarkStore>(
                builder: (context, _bookmarkStore, child) {
              return StreamBuilder<List<Feed>>(
                  stream: _bookmarkStore.feedStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Oops something went wrong'),
                            RaisedButton(
                              child: Text('Retry'),
                              onPressed: () {
                                _bookmarkStore.retry();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          // Todo: Replace with Shimmer
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasData && snapshot.data.isNotEmpty) {
                          final List<Feed> newsData = snapshot.data;
                          return IncrementallyLoadingListView(
                              hasMore: () => _bookmarkStore.hasMoreData,
                              itemCount: () => newsData.length,
                              loadMore: () async {
                                await _bookmarkStore.loadMoreData();
                              },
                              loadMoreOffsetFromBottom: 2,
                              itemBuilder: (BuildContext context, int index) {
                                final article = newsData[index];
                                if (index == newsData.length - 1 &&
                                    _bookmarkStore.hasMoreData &&
                                    !_bookmarkStore.isLoadingMore) {
                                  return Column(
                                    children: <Widget>[
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => _bookmarkStore
                                              .onFeedClick(article, context),
                                          child: BookmarkListItem(article),
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
                                      onTap: () => _bookmarkStore.onFeedClick(
                                          article, context),
                                      child: BookmarkListItem(article),
                                    ),
                                  );
                                }
                              });
                        }
                        return Center(
                          child: Text('Empty Data!'),
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
