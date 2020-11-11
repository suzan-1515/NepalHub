import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/widgets/news_source_feed_header.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/widgets/news_source_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsSourceFeedScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/news-source-feed';

  const NewsSourceFeedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsSourceUIModel newsSourceUIModel =
        ModalRoute.of(context).settings.arguments;
    return NewsProvider.sourceFeedBlocProvider(
      source: newsSourceUIModel,
      child: ScopedModel<NewsSourceUIModel>(
        model: newsSourceUIModel,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: BlocListener<SourceFollowUnFollowBloc,
                SourceFollowUnFollowState>(
              listener: (context, state) {
                if (state is SourceFollowSuccessState) {
                  ScopedModel.of<NewsSourceUIModel>(context).entity =
                      state.source;
                } else if (state is SourceUnFollowSuccessState) {
                  ScopedModel.of<NewsSourceUIModel>(context).entity =
                      state.source;
                }
              },
              child: NewsFilteringAppBar(
                header: const NewsSourceFeedHeader(),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const NewsSourceFeedList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
