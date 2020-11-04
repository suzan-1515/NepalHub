import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/topic_feeds/news_topic_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';

class NewsTopicFeedHeader extends StatelessWidget {
  const NewsTopicFeedHeader();

  Widget _buildHeader(BuildContext context, NewsTopicEntity topic) {
    return NewsFilterHeader(
      icon: DecorationImage(
        image: topic.isValidIcon
            ? AdvancedNetworkImage(topic.icon)
            : AssetImage('assets/images/user.png'),
        fit: BoxFit.cover,
      ),
      title: topic.title,
      isFollowed: topic.isFollowed,
      onTap: () {
        if (topic.isFollowed) {
          context
              .bloc<TopicFollowUnFollowBloc>()
              .add(TopicUnFollowEvent(topic: topic));
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: topic, eventType: 'topic_unfollow'));
        } else {
          context
              .bloc<TopicFollowUnFollowBloc>()
              .add(TopicFollowEvent(topic: topic));
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: topic, eventType: 'topic_follow'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicFollowUnFollowBloc, TopicFollowUnFollowState>(
      buildWhen: (previous, current) =>
          (current is TopicFollowInitialState) ||
          (current is TopicFollowSuccessState) ||
          (current is TopicUnFollowSuccessState),
      builder: (context, state) {
        if (state is TopicFollowSuccessState) {
          return _buildHeader(context, state.topic);
        } else if (state is TopicUnFollowSuccessState) {
          return _buildHeader(context, state.topic);
        }

        return _buildHeader(context, context.bloc<NewsTopicFeedBloc>().topic);
      },
    );
  }
}
