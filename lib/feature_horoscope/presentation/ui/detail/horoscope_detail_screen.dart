import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/dislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/like_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/share_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/undislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/unlike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/view_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';

class HoroscopeDetailScreen extends StatefulWidget {
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
  @override
  _HoroscopeDetailScreenState createState() => _HoroscopeDetailScreenState();
}

class _HoroscopeDetailScreenState extends State<HoroscopeDetailScreen> {
  HoroscopeUIModel _horoscopeUIModel;

  @override
  void initState() {
    super.initState();
    this._horoscopeUIModel = widget.horoscopeEntity.toUIModel;
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: widget.sign,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            backgroundImage:
                AdvancedNetworkImage(widget.signIcon, useDiskCache: true),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
                text: widget.sign,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                      text: '\n${_horoscopeUIModel.formattedDate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontStyle: FontStyle.italic)),
                  TextSpan(
                      text: '\n\n${widget.zodiac}',
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

  Widget _buildCommentBar() {
    return BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
      builder: (context, state) {
        return CommentBar(
          likeCount: _horoscopeUIModel?.formattedLikeCount ?? '0',
          onCommentTap: () => context
              .repository<NavigationService>()
              .toCommentsScreen(
                  context: context,
                  title:
                      '${_horoscopeUIModel.horoscopeEntity.type.value.toUpperCase()} Horoscope - ${widget.sign}',
                  postId: _horoscopeUIModel.horoscopeEntity.id),
          onShareTap: () {
            context
                .repository<ShareService>()
                .share(
                    threadId: _horoscopeUIModel.horoscopeEntity.id,
                    data:
                        '${_horoscopeUIModel.horoscopeEntity.title}\n${widget.sign}\n${widget.zodiac}\n#nepal_hub',
                    contentType: 'horoscope')
                .then((value) => context.bloc<ShareBloc>().add(Share()));
          },
          commentCount: _horoscopeUIModel?.formattedCommentCount ?? '0',
          isLiked: _horoscopeUIModel?.horoscopeEntity?.isLiked ?? false,
          shareCount: _horoscopeUIModel?.formattedShareCount ?? '0',
          userAvatar: null,
          onLikeTap: () {
            if (_horoscopeUIModel.horoscopeEntity.isLiked) {
              _horoscopeUIModel.unlike();
              context.bloc<LikeUnlikeBloc>().add(UnlikeEvent());
            } else {
              _horoscopeUIModel.like();
              context.bloc<LikeUnlikeBloc>().add(LikeEvent());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LikeUnlikeBloc>(
          create: (context) => LikeUnlikeBloc(
            horoscopeEntity: _horoscopeUIModel.horoscopeEntity,
            likeNewsFeedUseCase: context.repository<LikeHoroscopeUseCase>(),
            unLikeNewsFeedUseCase: context.repository<UnlikeHoroscopeUseCase>(),
          ),
        ),
        BlocProvider<DislikeBloc>(
          create: (context) => DislikeBloc(
            horoscopeEntity: _horoscopeUIModel.horoscopeEntity,
            dislikeHoroscopeUseCase:
                context.repository<DislikeHoroscopeUseCase>(),
            undislikeHoroscopeUseCase:
                context.repository<UndislikeHoroscopeUseCase>(),
          ),
        ),
        BlocProvider<ShareBloc>(
          create: (context) => ShareBloc(
            horoscopeEntity: _horoscopeUIModel.horoscopeEntity,
            shareNewsFeedUseCase: context.repository<ShareHoroscopeUseCase>(),
          ),
        ),
        BlocProvider<ViewBloc>(
          create: (context) => ViewBloc(
            horoscopeEntity: _horoscopeUIModel.horoscopeEntity,
            viewNewsFeedUseCase: context.repository<ViewHoroscopeUseCase>(),
          )..add(View()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
              '${_horoscopeUIModel.horoscopeEntity.type.value.toUpperCase()} Horoscope - ${widget.sign}'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                context
                    .repository<NavigationService>()
                    .toSettingsScreen(context: context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: _buildContent(context),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: _buildCommentBar(),
        ),
      ),
    );
  }
}
