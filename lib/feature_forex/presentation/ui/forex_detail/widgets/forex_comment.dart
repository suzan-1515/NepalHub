import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/extensions/forex_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';

class ForexComment extends StatelessWidget {
  const ForexComment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().currentUser;
    final forexUIModel =
        ScopedModel.of<ForexUIModel>(context, rebuildOnChange: true);
    return CommentBar(
      likeCount: forexUIModel.entity.likeCount ?? 0,
      onCommentTap: () => GetIt.I.get<NavigationService>().toCommentsScreen(
          context: context,
          threadTitle: forexUIModel.entity.currency.title,
          threadId: forexUIModel.entity.id,
          threadType: CommentThreadType.FOREX),
      onShareTap: () {
        GetIt.I
            .get<ShareService>()
            .share(
                threadId: forexUIModel.entity.id,
                data:
                    '${forexUIModel.entity.currency.title}\nBuying: ${forexUIModel.entity.buying}\nSelling: ${forexUIModel.entity.selling}\nPublished At: ${forexUIModel.entity.publishedAt.formatttedString}')
            .then((value) {
          context.read<ShareBloc>().add(Share(forex: forexUIModel.entity));
          return value;
        });
      },
      commentCount: forexUIModel.entity.commentCount ?? 0,
      isLiked: forexUIModel?.entity?.isLiked ?? false,
      shareCount: forexUIModel.entity.shareCount ?? 0,
      userAvatar: user?.avatar,
      onLikeTap: () {
        if (forexUIModel.entity.isLiked) {
          forexUIModel.entity = forexUIModel.entity.copyWith(
              isLiked: false, likeCount: forexUIModel.entity.likeCount - 1);
          context
              .read<LikeUnlikeBloc>()
              .add(UnlikeEvent(forex: forexUIModel.entity));
        } else {
          forexUIModel.entity = forexUIModel.entity.copyWith(
              isLiked: true, likeCount: forexUIModel.entity.likeCount + 1);
          context
              .read<LikeUnlikeBloc>()
              .add(LikeEvent(forex: forexUIModel.entity));
        }
      },
    );
  }
}
