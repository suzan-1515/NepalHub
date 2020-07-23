import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_list_item.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_store.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
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
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
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

  Widget _buildList(BookmarkStore _bookmarkStore) {
    return StreamBuilder<List<NewsFeed>>(
        stream: _bookmarkStore.feedStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: ErrorDataView(
              onRetry: () => _bookmarkStore.retry(),
            ));
          }
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Center(
                child: EmptyDataView(),
              );
            }
            return IncrementallyLoadingListView(
                hasMore: () => _bookmarkStore.hasMoreData,
                itemCount: () => snapshot.data.length,
                loadMore: () async {
                  await _bookmarkStore.loadMoreData(
                      after: snapshot.data.last?.timestamp);
                },
                loadMoreOffsetFromBottom: 2,
                itemBuilder: (BuildContext context, int index) {
                  final article = snapshot.data[index];
                  if (index == snapshot.data.length - 1 &&
                      _bookmarkStore.hasMoreData &&
                      !_bookmarkStore.isLoadingMore) {
                    return Column(
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => context
                                .read<NavigationService>()
                                .toFeedDetail(article, context),
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
                        onTap: () => context
                            .read<NavigationService>()
                            .toFeedDetail(article, context),
                        child: BookmarkListItem(article),
                      ),
                    );
                  }
                });
          }
          return Center(
            // Todo: Replace with Shimmer
            child: ProgressView(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<BookmarkStore>(
            builder: (_, _bookmarkStore, child) {
              return _buildList(_bookmarkStore);
            },
          ),
        ),
      ),
    );
  }
}
