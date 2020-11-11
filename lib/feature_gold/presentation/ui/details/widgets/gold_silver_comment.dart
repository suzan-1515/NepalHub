import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/comment_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/extensions/gold_silver_extensions.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';

class GoldSilverComment extends StatelessWidget {
  const GoldSilverComment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().currentUser;
    final goldSilverUIModel =
        ScopedModel.of<GoldSilverUIModel>(context, rebuildOnChange: true);
    return CommentBar(
      likeCount: goldSilverUIModel.entity.likeCount ?? 0,
      onCommentTap: () => Navigator.pushNamed(
        context,
        CommentScreen.ROUTE_NAME,
        arguments: CommentScreenArgs(
            threadTitle: goldSilverUIModel.entity.category.title,
            threadId: goldSilverUIModel.entity.id,
            threadType: CommentThreadType.GOLD),
      ),
      onShareTap: () {
        GetIt.I
            .get<ShareService>()
            .share(
                threadId: goldSilverUIModel.entity.id,
                data:
                    '${goldSilverUIModel.entity.category.title}(${goldSilverUIModel.entity.unit.label})\nPrice: NRs. ${goldSilverUIModel.entity.price.formattedString}\nPublished At: ${goldSilverUIModel.entity.publishedAt.formattedString}')
            .then((value) {
          context
              .read<ShareBloc>()
              .add(Share(goldSilver: goldSilverUIModel.entity));
          return value;
        });
      },
      commentCount: goldSilverUIModel.entity.commentCount ?? 0,
      isLiked: goldSilverUIModel?.entity?.isLiked ?? false,
      shareCount: goldSilverUIModel.entity.shareCount ?? 0,
      userAvatar: user?.avatar,
      onLikeTap: () {
        if (goldSilverUIModel.entity.isLiked) {
          goldSilverUIModel.entity = goldSilverUIModel.entity.copyWith(
              isLiked: false,
              likeCount: goldSilverUIModel.entity.likeCount - 1);
          context
              .read<LikeUnlikeBloc>()
              .add(UnlikeEvent(goldSilver: goldSilverUIModel.entity));
        } else {
          goldSilverUIModel.entity = goldSilverUIModel.entity.copyWith(
              isLiked: true, likeCount: goldSilverUIModel.entity.likeCount + 1);
          context
              .read<LikeUnlikeBloc>()
              .add(LikeEvent(goldSilver: goldSilverUIModel.entity));
        }
      },
    );
  }
}
