import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/category/category_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_compact_view.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/util/content_view_type.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

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
    final store = context.read<CategoryStore>();
    _setupObserver(store);
    store.loadInitialFeeds();
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

  _setupObserver(CategoryStore store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      }),
    ];
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(apiError: apiError);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CategoriesStore, CategoryStore, AuthenticationStore>(
        builder: (context, categoriesStore, categoryStore, authenticationStore,
            child) {
      return Observer(builder: (_) {
        final ContentViewType viewType = categoriesStore.view;
        return StreamBuilder<List<NewsFeedModel>>(
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
                        final NewsFeedModel feed = snapshot.data[index];
                        Widget articleWidget;
                        switch (viewType) {
                          case ContentViewType.LIST_VIEW:
                            articleWidget = NewsListView(
                              feed: feed,
                              authenticationStore: authenticationStore,
                            );
                            break;
                          case ContentViewType.THUMBNAIL_VIEW:
                            articleWidget = NewsThumbnailView(
                              feed: feed,
                              authenticationStore: authenticationStore,
                            );
                            break;
                          case ContentViewType.COMPACT_VIEW:
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
