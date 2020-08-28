import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/home/widgets/corona_section.dart';
import 'package:samachar_hub/pages/home/widgets/date_weather_section.dart';
import 'package:samachar_hub/pages/home/widgets/horoscope.dart';
import 'package:samachar_hub/pages/home/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/pages/home/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/pages/home/widgets/news_topics_section.dart';
import 'package:samachar_hub/pages/home/widgets/other_menu_section.dart';
import 'package:samachar_hub/pages/home/widgets/trending_news_section.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/main/main_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';
import 'package:samachar_hub/utils/date_time.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
// Reaction disposers
  List<ReactionDisposer> _disposers;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final store = context.read<HomeStore>();
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
    _scrollController?.dispose();
    super.dispose();
  }

  _setupObserver(store) {
    final mainStore = context.read<MainStore>();
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
      autorun((_) {
        if (mainStore.selectedPage == 0 &&
            mainStore.selectedPage == mainStore.lastSelectedPage)
          _scrollToTop(store);
      })
    ];
  }

  _scrollToTop(HomeStore store) {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildMixedSection(int index, Map<MixedDataType, dynamic> data,
      HomeStore personalisedStore) {
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
    if (index == 20 &&
        data.containsKey(MixedDataType.FOREX) &&
        data.containsKey(MixedDataType.HOROSCOPE)) {
      //sources view
      return OtherMenuSection(
        forexData: data[MixedDataType.FOREX],
        horoscopeData: data[MixedDataType.HOROSCOPE],
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildLatestFeed(int index, NewsFeed feed, HomeStore personalisedStore,
      authenticationStore) {
    Widget feedWidget;
    if (index % 4 == 0) {
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
          SectionHeading(
            title: 'Latest News',
            subtitle: 'Get latest news from different sources',
          ),
          feedWidget,
        ],
      );
    }

    return feedWidget;
  }

  SliverList _buildLatestNewsList(Map<MixedDataType, dynamic> data,
      HomeStore personalisedStore, AuthenticationStore authenticationStore) {
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
    return Consumer2<HomeStore, AuthenticationStore>(
        builder: (context, personalisedStore, authenticationStore, child) {
      return StreamBuilder<Map<MixedDataType, dynamic>>(
          stream: personalisedStore.dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return FadeInUp(
                duration: Duration(milliseconds: 200),
                child: Center(
                  child: ErrorDataView(
                    onRetry: () => personalisedStore.retry(),
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return FadeInUp(
                  duration: Duration(milliseconds: 200),
                  child: Center(
                    child: EmptyDataView(),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await personalisedStore.refresh();
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      sliver: SliverAppBar(
                        elevation: 0,
                        forceElevated: false,
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: RichText(
                            text: TextSpan(
                          text: 'Nepal Hub',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w800),
                          children: [
                            if (authenticationStore.isLoggedIn &&
                                !authenticationStore.user.isAnonymous)
                              TextSpan(
                                  text:
                                      '\nGood ${timeContextGreeting()} ${authenticationStore.user.firstName}',
                                  style: Theme.of(context).textTheme.caption),
                          ],
                        )),
                        pinned: false,
                        floating: true,
                      ),
                    ),
                    if (snapshot.data.containsKey(MixedDataType.DATE_INFO))
                      SliverToBoxAdapter(child: DateWeatherSection()),
                    if (snapshot.data.containsKey(MixedDataType.CORONA))
                      SliverToBoxAdapter(
                          child: CoronaSection(
                              data: snapshot.data[MixedDataType.CORONA])),
                    if (isEarlyMorning() &&
                        snapshot.data.containsKey(MixedDataType.HOROSCOPE))
                      SliverToBoxAdapter(
                          child: DailyHoroscope(
                              data: snapshot.data[MixedDataType.HOROSCOPE])),
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
                        hasScrollBody: false,
                        child: FadeInUp(
                          duration: Duration(milliseconds: 200),
                          child: Center(
                            child: EmptyDataView(
                              text: 'News feed is not available at the moment.',
                            ),
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
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: _buildList(),
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
}
