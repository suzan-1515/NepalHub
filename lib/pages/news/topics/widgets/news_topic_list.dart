import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

class NewsTopicList extends StatelessWidget {
  const NewsTopicList({
    Key key,
    @required this.context,
    @required this.store,
    @required this.authStore,
  }) : super(key: key);

  final BuildContext context;
  final NewsTopicFeedStore store;
  final AuthenticationStore authStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewsFeed>>(
      stream: store.dataStream,
      builder: (_, AsyncSnapshot<List<NewsFeed>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () => store.retry(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await store.refresh();
            },
            child: IncrementallyLoadingListView(
              itemCount: () => snapshot.data.length,
              loadMoreOffsetFromBottom: 2,
              itemBuilder: (_, int index) {
                Widget widget;
                if (index % 5 == 0) {
                  widget = NewsThumbnailView(
                    feed: snapshot.data[index],
                    authStore: authStore,
                  );
                } else {
                  widget = NewsListView(
                    feed: snapshot.data[index],
                    authStore: authStore,
                  );
                }

                return widget;
              },
              hasMore: () => store.hasMore,
              loadMore: () async => store.loadMoreData(),
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
