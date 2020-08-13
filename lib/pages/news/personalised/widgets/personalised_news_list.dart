import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';

class PersonalisedNewsList extends StatelessWidget {
  const PersonalisedNewsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PersonalisedNewsStore, AuthenticationStore>(
        builder: (context, personalisedStore, authenticationStore, child) {
      return StreamBuilder<List<NewsFeed>>(
        stream: personalisedStore.dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: ErrorDataView(
                onRetry: () => personalisedStore.retry(),
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
                await personalisedStore.refresh();
              },
              child: FadeInUp(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    final feed = snapshot.data[index];
                    Widget feedWidget;
                    if (index % 3 == 0) {
                      feedWidget = NewsThumbnailView(
                        feed: feed,
                        authStore: authenticationStore,
                      );
                    } else {
                      feedWidget = NewsListView(
                        feed: feed,
                        authStore: authenticationStore,
                      );
                    }

                    return feedWidget;
                  },
                ),
              ),
            );
          }
          return Center(child: ProgressView());
        },
      );
    });
  }
}
