import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_type_list_view/multi_type_list_view.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/preference_service.dart';
import 'package:samachar_hub/common/store/trending_news_store.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/personalised/personalised_item_builder.dart';
import 'package:samachar_hub/pages/personalised/personalised_store.dart';
import 'package:samachar_hub/pages/personalised/widgets/corona_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/pages/personalised/widgets/news_tags_section.dart';
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

  Widget _buildSection(MixedDataType type) {
    if (type == MixedDataType.DATE_INFO) {
      return DateWeatherSection();
    } else if (type == MixedDataType.CORONA) {
      return CoronaSection();
    } else if (type == MixedDataType.TRENDING_NEWS) {
      return ProxyProvider2<PreferenceService, NewsRepository,
          TrendingNewsStore>(
        child: TrendingNewsSection(),
        update: (BuildContext context, PreferenceService preferenceService,
                NewsRepository newsRepository, TrendingNewsStore previous) =>
            TrendingNewsStore(preferenceService, newsRepository),
        dispose: (context, store) => store.dispose(),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildLatestFeed(int index, Feed feed) {
    Widget feedWidget;
    if (index % 3 == 0) {
      feedWidget = NewsThumbnailView(feed);
    } else {
      feedWidget = NewsListView(feed: feed);
    }
    if (index == 3) {
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
      return StreamBuilder<List>(
          stream: personalisedStore.dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: ErrorDataView(
                  onRetry: () => personalisedStore.retry(),
                ),
              );
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: ProgressView());
              default:
                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(
                    child: EmptyDataView(
                      onRetry: () => personalisedStore.retry(),
                    ),
                  );
                }
                return RefreshIndicator(
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == 8) {
                        //topics view
                        if (personalisedStore
                                .sectionData[MixedDataType.NEWS_TOPIC] !=
                            null)
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SectionHeadingView(
                                title: 'Trending Topics',
                                subtitle:
                                    'Get the latest news on currently trending topics',
                              ),
                              NewsTagsSection(
                                item: personalisedStore
                                    .sectionData[MixedDataType.NEWS_TOPIC],
                              ),
                            ],
                          );
                      }
                      if (index == 13) {
                        //category view
                        if (personalisedStore
                                .sectionData[MixedDataType.NEWS_CATEGORY] !=
                            null)
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SectionHeadingView(
                                title: 'Discover',
                                subtitle:
                                    'Get the latest news on your favourite category',
                              ),
                              NewsCategoryMenuSection(
                                items: personalisedStore
                                    .sectionData[MixedDataType.NEWS_CATEGORY],
                              ),
                            ],
                          );
                      }
                      if (index == 18) {
                        //sources view
                        if (personalisedStore
                                .sectionData[MixedDataType.NEWS_SOURCE] !=
                            null)
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SectionHeadingView(
                                title: 'News Sources',
                                subtitle:
                                    'Explore news from your favourite news sources',
                              ),
                              NewsSourceMenuSection(
                                items: personalisedStore
                                    .sectionData[MixedDataType.NEWS_SOURCE],
                              ),
                            ],
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
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.hasError) {
                        return Center(
                          child: ErrorDataView(
                            onRetry: () => personalisedStore.retry(),
                          ),
                        );
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: ProgressView());
                        default:
                          if (!snapshot.hasData || snapshot.data.isEmpty) {
                            return Center(
                              child: EmptyDataView(
                                onRetry: () => personalisedStore.retry(),
                              ),
                            );
                          }

                          var data = snapshot.data[index];
                          if (data is MixedDataType) {
                            return _buildSection(data);
                          } else if (data is Feed) {
                            return _buildLatestFeed(index, data);
                          }

                          return SizedBox.shrink();
                      }
                    },
                  ),
                  onRefresh: () async => await personalisedStore.refresh(),
                );
            }
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
