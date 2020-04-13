import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/model/api_error.dart';
import 'package:samachar_hub/data/model/news.dart';
import 'package:samachar_hub/routes/home/pages/pages.dart';
import 'package:samachar_hub/routes/home/pages/personalised/logic/personalised_store.dart';
import 'package:samachar_hub/routes/home/widgets/news_compact_view.dart';
import 'package:samachar_hub/routes/home/widgets/news_list_view.dart';
import 'package:samachar_hub/routes/home/widgets/news_thumbnail_view.dart';

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
    store.fetchFeeds();
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

  _showErrorDialog(APIError apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              'API Error - ${apiError.code}',
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
        final APIError error = store.apiError;
        _showErrorDialog(error);
      })
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
            padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            child: Text('Top Stories',
                style: Theme.of(context).textTheme.headline),
          ),
          Expanded(
            child: Consumer<PersonalisedFeedStore>(
              builder: (context, personalisedStore, child) {
                return Observer(builder: (_) {
                  if (personalisedStore.loadingStatus) {
                    return Center(
                      // Todo: Replace with Shimmer
                      child: CircularProgressIndicator(),
                    );
                  }
                  final News newsData = personalisedStore.newsData;
                  if (null != newsData && newsData.feeds.isNotEmpty) {
                    final MenuItem viewType = personalisedStore.view;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: newsData.feeds.length,
                        itemBuilder: (BuildContext context, int position) {
                          Widget articleWidget;
                          final article = newsData.feeds[position];
                          switch (viewType) {
                            case MenuItem.LIST_VIEW:
                              articleWidget = NewsListView(article);
                              break;
                            case MenuItem.THUMBNAIL_VIEW:
                              articleWidget = NewsThumbnailView(article);
                              break;
                            case MenuItem.COMPACT_VIEW:
                              articleWidget = NewsCompactView(article);
                              break;
                          }
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => personalisedStore.onFeedClick(
                                  article, context),
                              child: articleWidget,
                            ),
                          );
                        });
                  } else
                    return Center(child: Text('Error!'));
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
