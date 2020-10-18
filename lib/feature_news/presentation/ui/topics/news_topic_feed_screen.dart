import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/topic_feeds/news_topic_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/widgets/news_topic_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsTopicFeedScreen extends StatelessWidget {
  final NewsTopicEntity newsTopicEntity;
  const NewsTopicFeedScreen({Key key, @required this.newsTopicEntity})
      : super(key: key);

  Widget _buildHeader(BuildContext context, NewsTopicUIModel topicUIModel) {
    return BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
      builder: (context, state) => NewsFilterHeader(
        icon: DecorationImage(
          image: AssetImage(topicUIModel.topic.isValidIcon
              ? topicUIModel.topic.icon
              : 'assets/images/user.png'),
          fit: BoxFit.cover,
        ),
        title: topicUIModel.topic.title,
        isFollowed: topicUIModel.topic.isFollowed,
        onTap: () {
          if (topicUIModel.topic.isFollowed) {
            topicUIModel.unfollow();
            context
                .bloc<FollowUnFollowBloc>()
                .add(FollowUnFollowUnFollowEvent());
          } else {
            topicUIModel.follow();
            context.bloc<FollowUnFollowBloc>().add(FollowUnFollowFollowEvent());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsProvider.topicFeedBlocProvider(
      newsTopicUIModel: newsTopicEntity.toUIModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: NewsFilteringAppBar(
            header: _buildHeader(
                context, context.bloc<NewsTopicFeedBloc>().topicModel),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewsTopicFeedList(),
            ),
          ),
        ),
      ),
    );
  }
}
