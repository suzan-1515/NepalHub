import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/personalised/personalised_store.dart';
import 'package:samachar_hub/pages/personalised/widgets/corona_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_topics_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/trending_news_section.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

import 'widgets/date_weather_section.dart';

class PersonalisedPage extends StatefulWidget {
  @override
  _PersonalisedPageState createState() => _PersonalisedPageState();
}

class _PersonalisedPageState extends State<PersonalisedPage> {
// Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<PersonalisedFeedStore>(context, listen: false);
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

  Widget _buildMixedSection(
      int index, PersonalisedFeedStore personalisedStore) {
    if (index == 5) {
      //topics view
      if (personalisedStore.sectionData[MixedDataType.NEWS_TOPIC] != null)
        return Consumer<NavigationService>(
          builder:
              (BuildContext context, NavigationService service, Widget child) {
            return NewsTopicsSection(
              item: personalisedStore.sectionData[MixedDataType.NEWS_TOPIC],
              onTap: (topic) =>
                  service.onNewsTagTapped(title: topic, context: context),
            );
          },
        );
    }
    if (index == 10) {
      //category view
      if (personalisedStore.sectionData[MixedDataType.NEWS_CATEGORY] != null)
        return NewsCategoryMenuSection(
          items: personalisedStore.sectionData[MixedDataType.NEWS_CATEGORY],
        );
    }
    if (index == 15) {
      //sources view
      if (personalisedStore.sectionData[MixedDataType.NEWS_SOURCE] != null)
        return NewsSourceMenuSection(
          items: personalisedStore.sectionData[MixedDataType.NEWS_SOURCE],
        );
    }

    if ((index + 1) % 6 == 0) {
      return Container(
        color: Colors.blueGrey,
        padding: const EdgeInsets.all(8),
        child: Text(
          'This is a ad section',
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildLatestFeed(
      int index, NewsFeedModel feed, PersonalisedFeedStore personalisedStore) {
    Widget feedWidget;
    if (index % 3 == 0) {
      feedWidget = NewsThumbnailView(feed);
    } else {
      feedWidget = NewsListView(feed: feed);
    }
    if (index == 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeadingView(
            title: 'Latest News',
            subtitle: 'Get latest news from different sources',
          ),
          feedWidget,
        ],
      );
    }
    return feedWidget;
  }

  Widget _buildList() {
    return Consumer<PersonalisedFeedStore>(
        builder: (context, personalisedStore, child) {
      return RefreshIndicator(
        onRefresh: () async {
          await personalisedStore.refresh();
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  DateWeatherSection(),
                  CoronaSection(),
                  ProxyProvider<NewsRepository, TrendingNewsStore>(
                    child: TrendingNewsSection(),
                    update: (BuildContext context,
                            NewsRepository newsRepository,
                            TrendingNewsStore previous) =>
                        TrendingNewsStore(newsRepository),
                    dispose: (context, store) => store.dispose(),
                  ),
                ],
                addAutomaticKeepAlives: true,
              ),
            ),
            StreamBuilder<List<NewsFeedModel>>(
                stream: personalisedStore.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: ErrorDataView(
                          onRetry: () => personalisedStore.retry(),
                        ),
                      ),
                    );
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: ProgressView()),
                      );
                    default:
                      if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: EmptyDataView(
                              onRetry: () => personalisedStore.retry(),
                            ),
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index.isOdd) {
                              return _buildMixedSection(
                                  index ~/ 2, personalisedStore);
                            }
                            return _buildLatestFeed(index,
                                snapshot.data[index ~/ 2], personalisedStore);
                          },
                          childCount: math.max(0, snapshot.data.length * 2 - 1),
                        ),
                      );
                  }
                }),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PageHeading(
            title: 'Top Stories',
          ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }
}

enum MixedDataType {
  DATE_INFO,
  TRENDING_NEWS,
  LATEST_NEWS,
  NEWS_TOPIC,
  NEWS_CATEGORY,
  NEWS_SOURCE,
  FOREX,
  HOROSCOPE,
  CORONA
}
