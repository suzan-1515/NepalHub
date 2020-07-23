import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/personalised/personalised_store.dart';
import 'package:samachar_hub/pages/personalised/widgets/corona_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_topics_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/other_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/trending_news_section.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

import 'widgets/date_weather_section.dart';

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
    final store = context.read<PersonalisedFeedStore>();
    _setupObserver(store);
    store.loadInitialData();
    final newsSettingNotifier = context.read<NewsSettingNotifier>();
    newsSettingNotifier.addListener(() {
      store.refresh();
    });
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

  Widget _buildMixedSection(int index, Map<MixedDataType, dynamic> data,
      PersonalisedFeedStore personalisedStore) {
    if (index == 5 && data.containsKey(MixedDataType.NEWS_TOPIC)) {
      //topics view
      final topics = data[MixedDataType.NEWS_TOPIC];
      return NewsTopicsSection(
        items: topics,
        onTap: (topic) =>
            context.read<NavigationService>().toNewsTopicFeedScreen(
                  topicModel: topic,
                  context: context,
                ),
      );
    }
    if (index == 10 && data.containsKey(MixedDataType.NEWS_CATEGORY)) {
      //category view
      return NewsCategoryMenuSection(
        items: data[MixedDataType.NEWS_CATEGORY],
      );
    }
    if (index == 15 && data.containsKey(MixedDataType.NEWS_SOURCE)) {
      //sources view
      return NewsSourceMenuSection(
        items: data[MixedDataType.NEWS_SOURCE],
      );
    }
    if (index == 20 && data.containsKey(MixedDataType.FOREX)) {
      //sources view
      return OtherMenuSection(
        forexData: data[MixedDataType.FOREX],
      );
    }

    // if ((index + 1) % 6 == 0) {
    //   return Container(
    //     color: Colors.blueGrey,
    //     padding: const EdgeInsets.all(8),
    //     child: Text(
    //       'This is a ad section',
    //       style: Theme.of(context).textTheme.headline6,
    //     ),
    //   );
    // }

    return SizedBox.shrink();
  }

  Widget _buildLatestFeed(int index, NewsFeed feed,
      PersonalisedFeedStore personalisedStore, authenticationStore) {
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

  SliverList _buildLatestNewsList(
      Map<MixedDataType, dynamic> data,
      PersonalisedFeedStore personalisedStore,
      AuthenticationStore authenticationStore) {
    final feeds = data[MixedDataType.LATEST_NEWS];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return _buildLatestFeed(itemIndex, feeds[itemIndex],
                personalisedStore, authenticationStore);
          } else {
            return _buildMixedSection(itemIndex, data, personalisedStore);
          }
        },
        childCount: math.max(0, feeds.length * 2 - 1),
        semanticIndexCallback: (Widget _, int index) {
          return index.isEven ? index ~/ 2 : null;
        },
      ),
    );
  }

  Widget _buildList() {
    return Consumer2<PersonalisedFeedStore, AuthenticationStore>(
        builder: (context, personalisedStore, authenticationStore, child) {
      return StreamBuilder<Map<MixedDataType, dynamic>>(
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
                child: CustomScrollView(
                  slivers: <Widget>[
                    if (snapshot.data.containsKey(MixedDataType.DATE_INFO))
                      SliverToBoxAdapter(child: DateWeatherSection()),
                    if (snapshot.data.containsKey(MixedDataType.CORONA))
                      SliverToBoxAdapter(
                          child: CoronaSection(
                              data: snapshot.data[MixedDataType.CORONA])),
                    if (snapshot.data.containsKey(MixedDataType.TRENDING_NEWS))
                      SliverToBoxAdapter(
                          child: TrendingNewsSection(
                        feeds: snapshot.data[MixedDataType.TRENDING_NEWS],
                      )),
                    if (snapshot.data.containsKey(MixedDataType.LATEST_NEWS))
                      _buildLatestNewsList(
                          snapshot.data, personalisedStore, authenticationStore)
                    else
                      SliverFillRemaining(
                        child: Center(
                          child: EmptyDataView(
                            text: 'News feed is not available at the moment.',
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
            return Center(child: ProgressView());
          });
    });
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

  @override
  bool get wantKeepAlive => true;
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
  CORONA,
  EMPTY
}
