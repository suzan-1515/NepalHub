import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';

class Source extends StatelessWidget {
  const Source({
    Key key,
    @required this.context,
    @required this.feedUIModel,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedUIModel feedUIModel;

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
          child: CachedImage(feedUIModel.newsSourceUIModel.source.favicon),
        ),
        SizedBox(width: 8),
        BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
          buildWhen: (previous, current) =>
              current is FollowUnFollowFollowedState ||
              current is FollowUnFollowUnFollowedState,
          builder: (context, state) => RichText(
            text: TextSpan(
                text: '${feedUIModel.newsSourceUIModel.source.title}',
                style: Theme.of(context).textTheme.subtitle2,
                children: [
                  TextSpan(text: '\n'),
                  TextSpan(
                      text:
                          '${feedUIModel.newsSourceUIModel.formattedFollowerCount} followers',
                      style: Theme.of(context).textTheme.caption),
                ]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 4),
        Spacer(),
        ZoomIn(
          duration: const Duration(milliseconds: 200),
          child: BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
            builder: (context, state) => FlatButton(
              visualDensity: VisualDensity.compact,
              color: feedUIModel.newsSourceUIModel.source.isFollowed
                  ? Colors.blue
                  : null,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(6),
                    right: Radius.circular(6),
                  )),
              onPressed: () {
                if (feedUIModel.newsSourceUIModel.source.isFollowed) {
                  feedUIModel.newsSourceUIModel.unfollow();
                  context
                      .bloc<FollowUnFollowBloc>()
                      .add(FollowUnFollowUnFollowEvent());
                } else {
                  feedUIModel.newsSourceUIModel.follow();
                  context
                      .bloc<FollowUnFollowBloc>()
                      .add(FollowUnFollowFollowEvent());
                }
              },
              child: Row(
                children: [
                  Icon(
                    feedUIModel.newsSourceUIModel.source.isFollowed
                        ? Icons.star
                        : Icons.star_border,
                    color: feedUIModel.newsSourceUIModel.source.isFollowed
                        ? Colors.white
                        : Colors.blue,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    feedUIModel.newsSourceUIModel.source.isFollowed
                        ? 'Following'
                        : 'Follow',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: feedUIModel.newsSourceUIModel.source.isFollowed
                            ? Colors.white
                            : Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
