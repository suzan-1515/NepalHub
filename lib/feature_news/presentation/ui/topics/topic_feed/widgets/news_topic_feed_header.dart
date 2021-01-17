import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsTopicFeedHeader extends StatelessWidget {
  const NewsTopicFeedHeader();

  @override
  Widget build(BuildContext context) {
    final topic =
        ScopedModel.of<NewsTopicUIModel>(context, rebuildOnChange: true);
    return NewsFilterHeader(
      icon: DecorationImage(
        image: topic.entity.isValidIcon
            ? CachedNetworkImageProvider(topic.entity.icon)
            : AssetImage('assets/images/user.png'),
        fit: BoxFit.cover,
      ),
      title: topic.entity.title,
      isFollowed: topic.entity.isFollowed,
      onTap: () {
        if (topic.entity.isFollowed) {
          topic.unFollow();
          context
              .read<TopicFollowUnFollowBloc>()
              .add(TopicUnFollowEvent(topic: topic.entity));
        } else {
          topic.follow();
          context
              .read<TopicFollowUnFollowBloc>()
              .add(TopicFollowEvent(topic: topic.entity));
        }
      },
    );
  }
}
