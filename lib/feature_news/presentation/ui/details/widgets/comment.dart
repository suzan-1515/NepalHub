import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsDetailComment extends StatelessWidget {
  const NewsDetailComment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed =
        ScopedModel.of<NewsFeedUIModel>(context, rebuildOnChange: true);
    final user = context.watch<AuthBloc>().currentUser;
    return CommentBar(
      likeCount: feed.entity.likeCount ?? 0,
      onCommentTap: () => GetIt.I.get<NavigationService>().toCommentsScreen(
          context: context,
          threadTitle: feed.entity.title,
          threadId: feed.entity.id,
          threadType: CommentThreadType.NEWS_FEED),
      onShareTap: () {
        GetIt.I
            .get<ShareService>()
            .share(
              threadId: feed.entity.id,
              data: feed.entity.link,
              contentType: 'news_feed',
            )
            .then((value) {
          context.read<ShareBloc>().add(Share(feed: feed.entity));
          return value;
        });
      },
      commentCount: feed.entity.commentCount ?? 0,
      isLiked: feed.entity.isLiked ?? false,
      shareCount: feed.entity.shareCount ?? 0,
      userAvatar: user?.avatar,
      onLikeTap: () {
        if (feed.entity.isLiked) {
          feed.unLike();
          context.read<LikeUnlikeBloc>().add(UnlikeEvent(feed: feed.entity));
        } else {
          feed.like();
          context.read<LikeUnlikeBloc>().add(LikeEvent(feed: feed.entity));
        }
      },
    );
  }
}
