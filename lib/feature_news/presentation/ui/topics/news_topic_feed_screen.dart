import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/topic_feeds/news_topic_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/widgets/news_topic_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsTopicFeedScreen extends StatefulWidget {
  const NewsTopicFeedScreen({Key key}) : super(key: key);
  @override
  _NewsTopicFeedScreenState createState() => _NewsTopicFeedScreenState();
}

class _NewsTopicFeedScreenState extends State<NewsTopicFeedScreen> {
  NewsTopicUIModel topicUIModel;
  @override
  void initState() {
    super.initState();
    topicUIModel = context.bloc<NewsTopicFeedBloc>().topicModel;
  }

  Widget _buildHeader() {
    return BlocListener<FollowUnFollowBloc, FollowUnFollowState>(
      listener: (context, state) {
        if (state is FollowedState) {
          topicUIModel.follow();
        } else if (state is UnFollowedState) {
          topicUIModel.unfollow();
        }
      },
      child: NewsFilterHeader(
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
                .add(UnFollowEvent(topicModel: topicUIModel));
          } else {
            topicUIModel.follow();
            context
                .bloc<FollowUnFollowBloc>()
                .add(FollowEvent(topicModel: topicUIModel));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: NewsFilteringAppBar(
          header: _buildHeader(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewsTopicFeedList(),
          ),
        ),
      ),
    );
  }
}
