import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSourceListItem extends StatelessWidget {
  const NewsSourceListItem({
    Key key,
    @required this.source,
  }) : super(key: key);

  final NewsSourceEntity source;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          GetIt.I
              .get<NavigationService>()
              .toNewsSourceFeedScreen(context: context, source: source);
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
            source.icon,
            tag: source.code,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            source.title,
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
                '${source.followerCount.compactFormat} Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              FollowUnFollowButton(
                isFollowed: source.isFollowed,
                onTap: () {
                  if (source.isFollowed) {
                    GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                        data: source, eventType: 'source_unfollow'));
                    context
                        .bloc<SourceFollowUnFollowBloc>()
                        .add(SourceUnFollowEvent(source: source));
                  } else {
                    GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                        data: source, eventType: 'source_follow'));
                    context
                        .bloc<SourceFollowUnFollowBloc>()
                        .add(SourceFollowEvent(source: source));
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
