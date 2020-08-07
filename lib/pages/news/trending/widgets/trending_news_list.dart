import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';

class TrendingNewsList extends StatelessWidget {
  const TrendingNewsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TrendingNewsStore, AuthenticationStore>(
      builder: (context, store, authenticationStore, child) {
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
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int index) {
                    return NewsListView(
                      feed: snapshot.data[index],
                      authStore: authenticationStore,
                    );
                  },
                ),
              );
            } else {
              return Center(child: ProgressView());
            }
          },
        );
      },
    );
  }
}
