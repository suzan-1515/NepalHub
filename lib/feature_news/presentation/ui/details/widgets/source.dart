import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:scoped_model/scoped_model.dart';

class Source extends StatelessWidget {
  const Source({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 42,
          width: 42,
          child: CachedImage(feed.entity.source.favicon),
        ),
        const SizedBox(width: 8),
        const SourceFollowerCount(),
        const SizedBox(width: 4),
        const Spacer(),
        ZoomIn(
          duration: const Duration(milliseconds: 200),
          child: const SourceFollowButton(),
        ),
      ],
    );
  }
}

class SourceFollowButton extends StatelessWidget {
  const SourceFollowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed =
        ScopedModel.of<NewsFeedUIModel>(context, rebuildOnChange: true);
    return FlatButton(
      key: UniqueKey(),
      visualDensity: VisualDensity.compact,
      color: feed.entity.source.isFollowed ? Colors.blue : null,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(6),
            right: Radius.circular(6),
          )),
      onPressed: () {
        if (feed.entity.source.isFollowed) {
          feed.unFollowSource();
          context
              .read<SourceFollowUnFollowBloc>()
              .add(SourceUnFollowEvent(source: feed.entity.source));
        } else {
          feed.followSource();
          context
              .read<SourceFollowUnFollowBloc>()
              .add(SourceFollowEvent(source: feed.entity.source));
        }
      },
      child: Row(
        children: [
          Icon(
            feed.entity.source.isFollowed ? Icons.star : Icons.star_border,
            color: feed.entity.source.isFollowed ? Colors.white : Colors.blue,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            feed.entity.source.isFollowed ? 'Following' : 'Follow',
            style: Theme.of(context).textTheme.caption.copyWith(
                color:
                    feed.entity.source.isFollowed ? Colors.white : Colors.blue),
          ),
        ],
      ),
    );
  }
}

class SourceFollowerCount extends StatelessWidget {
  const SourceFollowerCount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed =
        ScopedModel.of<NewsFeedUIModel>(context, rebuildOnChange: true);
    return RichText(
      text: TextSpan(
          text: '${feed.entity.source.title}',
          style: Theme.of(context).textTheme.subtitle2,
          children: [
            TextSpan(text: '\n'),
            TextSpan(
                text:
                    '${feed.entity.source.followerCount.compactFormat} followers',
                style: Theme.of(context).textTheme.caption),
          ]),
      overflow: TextOverflow.ellipsis,
    );
  }
}
