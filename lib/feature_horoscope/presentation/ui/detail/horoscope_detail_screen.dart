import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';

class HoroscopeDetailScreen extends StatelessWidget {
  final String sign;
  final String signIcon;
  final String zodiac;
  final HoroscopeEntity horoscopeEntity;

  const HoroscopeDetailScreen({
    Key key,
    @required this.sign,
    @required this.signIcon,
    @required this.zodiac,
    @required this.horoscopeEntity,
  }) : super(key: key);

  Widget _buildContent(
      BuildContext context, HoroscopeUIModel horoscopeUIModel) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: sign,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            backgroundImage: AdvancedNetworkImage(signIcon, useDiskCache: true),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
                text: sign,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                      text: '\n${horoscopeUIModel.formattedDate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontStyle: FontStyle.italic)),
                  TextSpan(
                      text: '\n\n$zodiac',
                      style: Theme.of(context).textTheme.subtitle1),
                ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAdView(context, store) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 60,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(child: Text('Ad section')),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentBar(
      BuildContext context, HoroscopeUIModel horoscopeUIModel) {
    final user = context.bloc<AuthBloc>().currentUser;
    return BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
      builder: (context, state) {
        return CommentBar(
          likeCount: horoscopeUIModel.horoscopeEntity.likeCount ?? 0,
          onCommentTap: () => GetIt.I.get<NavigationService>().toCommentsScreen(
              context: context,
              threadTitle:
                  '${horoscopeUIModel.horoscopeEntity.type.value.toUpperCase()} Horoscope - ${sign}',
              threadId: horoscopeUIModel.horoscopeEntity.id,
              threadType: CommentThreadType.HOROSCOPE),
          onShareTap: () {
            GetIt.I
                .get<ShareService>()
                .share(
                    threadId: horoscopeUIModel.horoscopeEntity.id,
                    data:
                        '${horoscopeUIModel.horoscopeEntity.title}\n$sign\n$zodiac\n#nepal_hub',
                    contentType: 'horoscope')
                .then((value) => context.bloc<ShareBloc>().add(Share()));
          },
          commentCount: horoscopeUIModel.horoscopeEntity.commentCount ?? 0,
          isLiked: horoscopeUIModel?.horoscopeEntity?.isLiked ?? false,
          shareCount: horoscopeUIModel.horoscopeEntity.shareCount ?? 0,
          userAvatar: user?.avatar,
          onLikeTap: () {
            if (horoscopeUIModel.horoscopeEntity.isLiked) {
              horoscopeUIModel.unlike();
              context.bloc<LikeUnlikeBloc>().add(UnlikeEvent());
            } else {
              horoscopeUIModel.like();
              context.bloc<LikeUnlikeBloc>().add(LikeEvent());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final horoscopeUIModel = horoscopeEntity.toUIModel;
    return HoroscopeProvider.horoscopeDetailBlocProvider(
      horoscopeUIModel: horoscopeUIModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
              '${horoscopeEntity.type.value.toUpperCase()} Horoscope - $sign'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                GetIt.I
                    .get<NavigationService>()
                    .toSettingsScreen(context: context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (BuildContext context) => SingleChildScrollView(
                child: _buildContent(context, horoscopeUIModel),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: _buildCommentBar(context, horoscopeUIModel),
        ),
      ),
    );
  }
}
