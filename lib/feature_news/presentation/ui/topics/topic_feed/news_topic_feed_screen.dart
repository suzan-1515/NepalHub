import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/widgets/news_topic_feed_header.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/widgets/news_topic_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsTopicFeedScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/news-topic-feed';

  const NewsTopicFeedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsTopicUIModel newsTopicUIModel =
        ModalRoute.of(context).settings.arguments;
    return NewsProvider.topicFeedBlocProvider(
      topicUIModel: newsTopicUIModel,
      child: ScopedModel<NewsTopicUIModel>(
        model: newsTopicUIModel,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child:
                BlocListener<TopicFollowUnFollowBloc, TopicFollowUnFollowState>(
              listener: (context, state) {
                if (state is TopicFollowSuccessState) {
                  ScopedModel.of<NewsTopicUIModel>(context).entity =
                      state.topic;
                }
                if (state is TopicUnFollowSuccessState) {
                  ScopedModel.of<NewsTopicUIModel>(context).entity =
                      state.topic;
                }
              },
              child: NewsFilteringAppBar(
                header: const NewsTopicFeedHeader(),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const NewsTopicFeedList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
