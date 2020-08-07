import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_compact_view.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/news/category/news_category_feed_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/content_view_type.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsCategoryView extends StatefulWidget {
  const NewsCategoryView();

  @override
  _NewsCategoryViewState createState() => _NewsCategoryViewState();
}

class _NewsCategoryViewState extends State<NewsCategoryView> {
  List<ReactionDisposer> _disposers;
  @override
  void initState() {
    super.initState();
    final store = context.read<NewsCategoryFeedStore>();
    _setupObserver(store);
    store.loadInitialData();
    final newsSettingNotifier = context.read<NewsSettingNotifier>();
    newsSettingNotifier.addListener(() {
      if (newsSettingNotifier.setting == NewsSetting.SOURCE) {
        store.refresh();
      }
    });
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewsCategoryScreenStore, NewsCategoryFeedStore,
            AuthenticationStore>(
        builder: (context, categoriesStore, categoryStore, authenticationStore,
            child) {
      return Observer(builder: (_) {
        final ContentViewStyle viewType = categoriesStore.view;
        return StreamBuilder<List<NewsFeed>>(
            stream: categoryStore.dataStream,
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: ErrorDataView(
                    onRetry: () => categoryStore.retry(),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Center(child: EmptyDataView());
                }

                return RefreshIndicator(
                  child: IncrementallyLoadingListView(
                      hasMore: () => categoryStore.hasMore,
                      itemCount: () => snapshot.data.length,
                      loadMore: () async {
                        await categoryStore.loadMoreData();
                      },
                      loadMoreOffsetFromBottom: 2,
                      itemBuilder: (_, int index) {
                        final NewsFeed feed = snapshot.data[index];
                        Widget articleWidget;
                        switch (viewType) {
                          case ContentViewStyle.LIST_VIEW:
                            articleWidget = NewsListView(
                              feed: feed,
                              authStore: authenticationStore,
                            );
                            break;
                          case ContentViewStyle.THUMBNAIL_VIEW:
                            articleWidget = NewsThumbnailView(
                              feed: feed,
                              authStore: authenticationStore,
                            );
                            break;
                          case ContentViewStyle.COMPACT_VIEW:
                            articleWidget = AspectRatio(
                                aspectRatio: 16 / 9,
                                child: NewsCompactView(
                                  feed: feed,
                                ));
                            break;
                        }
                        if (index == snapshot.data.length - 1 &&
                            categoryStore.hasMore &&
                            !categoryStore.isLoading) {
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
                    await categoryStore.refresh();
                  },
                );
              }
              return Center(
                // Todo: Replace with Shimmer
                child: ProgressView(),
              );
            });
      });
    });
  }
}
