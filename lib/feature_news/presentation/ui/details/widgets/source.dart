import 'package:animate_do/animate_do.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';

class Source extends StatelessWidget {
  const Source({
    Key key,
    @required this.context,
    @required this.feed,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 42,
          width: 42,
          child: CachedImage(feed.source.favicon),
        ),
        SizedBox(width: 8),
        SourceFollowerCount(source: feed.source),
        SizedBox(width: 4),
        Spacer(),
        ZoomIn(
          duration: const Duration(milliseconds: 200),
          child: SourceFollowButton(source: feed.source),
        ),
      ],
    );
  }
}

class SourceFollowButton extends StatelessWidget {
  const SourceFollowButton({
    Key key,
    @required this.source,
  }) : super(key: key);

  final NewsSourceEntity source;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: UniqueKey(),
      visualDensity: VisualDensity.compact,
      color: source.isFollowed ? Colors.blue : null,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(6),
            right: Radius.circular(6),
          )),
      onPressed: () {
        if (source.isFollowed) {
          context
              .bloc<SourceFollowUnFollowBloc>()
              .add(SourceUnFollowEvent(source: source));
          GetIt.I.get<EventBus>().fire(
              NewsChangeEvent(data: source, eventType: 'source_unfollow'));
        } else {
          context
              .bloc<SourceFollowUnFollowBloc>()
              .add(SourceFollowEvent(source: source));
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: source, eventType: 'source_follow'));
        }
      },
      child: Row(
        children: [
          Icon(
            source.isFollowed ? Icons.star : Icons.star_border,
            color: source.isFollowed ? Colors.white : Colors.blue,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            source.isFollowed ? 'Following' : 'Follow',
            style: Theme.of(context).textTheme.caption.copyWith(
                color: source.isFollowed ? Colors.white : Colors.blue),
          ),
        ],
      ),
    );
  }
}

class SourceFollowerCount extends StatelessWidget {
  const SourceFollowerCount({
    Key key,
    @required this.source,
  }) : super(key: key);

  final NewsSourceEntity source;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: '${source.title}',
          style: Theme.of(context).textTheme.subtitle2,
          children: [
            TextSpan(text: '\n'),
            TextSpan(
                text: '${source.followerCount.compactFormat} followers',
                style: Theme.of(context).textTheme.caption),
          ]),
      overflow: TextOverflow.ellipsis,
    );
  }
}
