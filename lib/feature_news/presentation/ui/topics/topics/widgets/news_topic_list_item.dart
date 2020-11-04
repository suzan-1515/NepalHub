import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsTopicListItem extends StatelessWidget {
  const NewsTopicListItem({
    Key key,
    @required this.topic,
  }) : super(key: key);

  final NewsTopicEntity topic;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          GetIt.I
              .get<NavigationService>()
              .toNewsTopicFeedScreen(context: context, topic: topic);
        },
        leading: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: CachedImage(
            topic.icon,
            tag: topic.id,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            topic.title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${topic.followerCount.compactFormat} Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              FollowUnFollowButton(
                isFollowed: topic.isFollowed,
                onTap: () {
                  if (topic.isFollowed) {
                    GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                        data: topic, eventType: 'topic_unfollow'));
                    context
                        .bloc<TopicFollowUnFollowBloc>()
                        .add(TopicUnFollowEvent(topic: topic));
                  } else {
                    GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                        data: topic, eventType: 'topic_follow'));
                    context
                        .bloc<TopicFollowUnFollowBloc>()
                        .add(TopicFollowEvent(topic: topic));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
