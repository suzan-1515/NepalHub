import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/pages/personalised/personalised_store.dart';
import 'package:samachar_hub/pages/widgets/news_category_section.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';

class PersonalisedPage extends StatefulWidget {
  @override
  _PersonalisedPageState createState() => _PersonalisedPageState();
}

class _PersonalisedPageState extends State<PersonalisedPage>
    with AutomaticKeepAliveClientMixin {
// Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<PersonalisedFeedStore>(context, listen: false);
    _setupObserver(store);
    store.loadInitialFeeds();
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

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              'API Error - ${apiError.message}',
              style: Theme.of(context).textTheme.subhead,
            ),
            content: SingleChildScrollView(
              child: Text(
                apiError.message,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Text('Top Stories',
                    style: Theme.of(context).textTheme.headline),
              ),
              Expanded(
                child: Consumer2<PersonalisedFeedStore, NavigationService>(
                  builder:
                      (context, personalisedStore, _navigationService, child) {
                    return Observer(builder: (_) {
                      switch (personalisedStore.loadFeedItemsFuture.status) {
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
                                    personalisedStore.retry();
                                  },
                                ),
                              ],
                            ),
                          );
                        case FutureStatus.fulfilled:
                          final List<Feed> newsData =
                              personalisedStore.newsData;
                          if (null != newsData && newsData.isNotEmpty) {
                            return RefreshIndicator(
                              child: IncrementallyLoadingListView(
                                  hasMore: () => personalisedStore.hasMoreData,
                                  itemCount: () => newsData.length,
                                  loadMore: () async {
                                    await personalisedStore.loadMoreData();
                                  },
                                  loadMoreOffsetFromBottom: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final feed = newsData[index];
                                    Widget articleWidget;
                                    if (index == 0) {
                                      articleWidget = NewsCategoryMenuSection();
                                    } else if (index == 1) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Recommended stories for you',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                            children: <TextSpan>[
                                              TextSpan(text: '\n'),
                                              TextSpan(
                                                  text:
                                                      'Discover latest news from various sources',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle)
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (index % 3 == 0) {
                                        articleWidget = NewsThumbnailView(feed);
                                      } else {
                                        articleWidget =
                                            NewsListView(feed: feed);
                                      }
                                    }
                                    if (index == newsData.length - 1 &&
                                        personalisedStore.hasMoreData &&
                                        !personalisedStore.isLoadingMore) {
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
                                await personalisedStore.refresh();
                              },
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
                                      personalisedStore.retry();
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
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
