import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsTopicListItem extends StatelessWidget {
  const NewsTopicListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topic =
        ScopedModel.of<NewsTopicUIModel>(context, rebuildOnChange: true);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          GetIt.I
              .get<NavigationService>()
              .toNewsTopicFeedScreen(context: context, topicUIModel: topic);
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
            topic.entity.icon,
            tag: topic.entity.id,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            topic.entity.title,
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
                '${topic.entity.followerCount.compactFormat} Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              FollowUnFollowButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
