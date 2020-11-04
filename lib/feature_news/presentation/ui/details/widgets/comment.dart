import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';

class NewsDetailComment extends StatelessWidget {
  const NewsDetailComment({
    Key key,
    @required this.context,
    @required this.feed,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    return CommentBar(
      likeCount: feed.likeCount ?? 0,
      onCommentTap: () => GetIt.I.get<NavigationService>().toCommentsScreen(
          context: context,
          threadTitle: feed.title,
          threadId: feed.id,
          threadType: CommentThreadType.NEWS_FEED),
      onShareTap: () {
        GetIt.I
            .get<ShareService>()
            .share(
              threadId: feed.id,
              data: feed.link,
              contentType: 'news_feed',
            )
            .then((value) {
          context.bloc<ShareBloc>().add(Share(feed: feed));
          return value;
        });
      },
      commentCount: feed.commentCount ?? 0,
      isLiked: feed.isLiked ?? false,
      shareCount: feed.shareCount ?? 0,
      userAvatar: user?.avatar,
      onLikeTap: () {
        if (feed.isLiked) {
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: feed, eventType: 'unlike'));
          context.bloc<LikeUnlikeBloc>().add(UnlikeEvent(feed: feed));
        } else {
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: feed, eventType: 'like'));
          context.bloc<LikeUnlikeBloc>().add(LikeEvent(feed: feed));
        }
      },
    );
  }
}
