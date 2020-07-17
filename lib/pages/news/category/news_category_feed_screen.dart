import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/category/news_category_feed_store.dart';
import 'package:samachar_hub/pages/news/source/news_source_feed_store.dart';
import 'package:samachar_hub/pages/news/widgets/news_filtering_appbar.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

class NewsCategoryFeedScreen extends StatefulWidget {
  const NewsCategoryFeedScreen({Key key}) : super(key: key);
  @override
  _NewsCategoryFeedScreenState createState() => _NewsCategoryFeedScreenState();
}

class _NewsCategoryFeedScreenState extends State<NewsCategoryFeedScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<NewsCategoryFeedStore>();
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

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(
            apiError: apiError,
          );
        },
      );
  }

  _setupObserver(store) {
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
      })
    ];
  }

  Widget _buildList() {
    return Consumer2<NewsCategoryFeedStore, AuthenticationStore>(
      builder: (_, store, authenticationStore, __) {
        return StreamBuilder<List<NewsFeedModel>>(
          stream: store.dataStream,
          builder: (_, AsyncSnapshot<List<NewsFeedModel>> snapshot) {
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
                        authenticationStore: authenticationStore,
                      );
                    } else {
                      widget = NewsListView(
                        feed: snapshot.data[index],
                        authenticationStore: authenticationStore,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: NewsFilteringAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildList(),
          ),
        ),
      ),
    );
  }
}
