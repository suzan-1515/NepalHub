import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:scoped_model/scoped_model.dart';

class HoroscopeComment extends StatelessWidget {
  const HoroscopeComment({
    Key key,
    @required this.signIndex,
  }) : super(key: key);

  final int signIndex;

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    final horoscopeUIModel =
        ScopedModel.of<HoroscopeUIModel>(context, rebuildOnChange: true);
    return CommentBar(
      likeCount: horoscopeUIModel.entity.likeCount ?? 0,
      onCommentTap: () => GetIt.I.get<NavigationService>().toCommentsScreen(
          context: context,
          threadTitle:
              '${horoscopeUIModel.entity.type.value.toUpperCase()} Horoscope - ${HOROSCOPE_SIGNS[Language.NEPALI][signIndex]}',
          threadId: horoscopeUIModel.entity.id,
          threadType: CommentThreadType.HOROSCOPE),
      onShareTap: () {
        GetIt.I
            .get<ShareService>()
            .share(
                threadId: horoscopeUIModel.entity.id,
                data:
                    'Horoscope (${horoscopeUIModel.entity.type.value.toUpperCase()})\n${horoscopeUIModel.entity.horoscopeByIndex(signIndex, Language.NEPALI)})\nPublished At: ${horoscopeUIModel.entity.publishedAt.formattedString}')
            .then((value) {
          context
              .bloc<ShareBloc>()
              .add(Share(horoscope: horoscopeUIModel.entity));
          return value;
        });
      },
      commentCount: horoscopeUIModel.entity.commentCount ?? 0,
      isLiked: horoscopeUIModel?.entity?.isLiked ?? false,
      shareCount: horoscopeUIModel.entity.shareCount ?? 0,
      userAvatar: user?.avatar,
      onLikeTap: () {
        if (horoscopeUIModel.entity.isLiked) {
          horoscopeUIModel.entity = horoscopeUIModel.entity.copyWith(
              isLiked: false, likeCount: horoscopeUIModel.entity.likeCount - 1);
          context
              .bloc<LikeUnlikeBloc>()
              .add(UnlikeEvent(horoscope: horoscopeUIModel.entity));
        } else {
          horoscopeUIModel.entity = horoscopeUIModel.entity.copyWith(
              isLiked: true, likeCount: horoscopeUIModel.entity.likeCount + 1);
          context
              .bloc<LikeUnlikeBloc>()
              .add(LikeEvent(horoscope: horoscopeUIModel.entity));
        }
      },
    );
  }
}
