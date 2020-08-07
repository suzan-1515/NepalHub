import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/bookmark/widgets/bookmark_list_item.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/news/bookmark/bookmark_store.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

class BookmarkedNewsList extends StatelessWidget {
  const BookmarkedNewsList({
    Key key,
    @required BookmarkStore bookmarkStore,
  })  : _bookmarkStore = bookmarkStore,
        super(key: key);

  final BookmarkStore _bookmarkStore;

  @override
  Widget build(BuildContext context) {
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
                child: EmptyDataView(
                  text: 'You have not saved any news yet.',
                ),
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
          return Center(child: ProgressView());
        });
  }
}
