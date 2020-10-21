import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart'
    as shareBloc;
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/round_button.dart';

class Share extends StatelessWidget {
  final NewsFeedUIModel feedUIModel;

  const Share({Key key, this.feedUIModel}) : super(key: key);

  Widget _buildLikeButton(BuildContext context) {
    return BlocConsumer<LikeUnlikeBloc, LikeUnlikeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RoundIconButton(
            color: Theme.of(context).accentColor.withOpacity(0.7),
            icon: feedUIModel.feedEntity.isLiked
                ? FontAwesomeIcons.solidThumbsUp
                : FontAwesomeIcons.thumbsUp,
            onTap: () {
              if (feedUIModel.feedEntity.isLiked) {
                feedUIModel.unlike();
                context.bloc<LikeUnlikeBloc>().add(UnlikeEvent());
              } else {
                feedUIModel.like();
                context.bloc<LikeUnlikeBloc>().add(LikeEvent());
              }
            },
            text: feedUIModel.feedEntity.likeCount == 0
                ? 'Like'
                : '${feedUIModel.formattedLikeCount}',
          );
        });
  }

  Widget _buildFacebookShareButton(BuildContext context) {
    return RoundIconButton(
      color: Color.fromARGB(255, 66, 103, 178),
      icon: FontAwesomeIcons.facebookF,
      onTap: () => context
          .repository<ShareService>()
          .shareToFacebook(
              threadId: feedUIModel.feedEntity.id,
              title: feedUIModel.feedEntity.title,
              url: feedUIModel.feedEntity.link,
              contentType: 'news_feed')
          .then((value) {
        context.bloc<shareBloc.ShareBloc>().add(shareBloc.Share());
      }),
      text: 'Share',
    );
  }

  Widget _buildTwitterShareButton(BuildContext context) {
    return RoundIconButton(
      color: Color.fromARGB(255, 29, 161, 242),
      icon: FontAwesomeIcons.twitter,
      onTap: () => context
          .repository<ShareService>()
          .shareToTwitter(
              threadId: feedUIModel.feedEntity.id,
              title: feedUIModel.feedEntity.title,
              url: feedUIModel.feedEntity.link,
              contentType: 'news_feed')
          .then((value) {
        context.bloc<shareBloc.ShareBloc>().add(shareBloc.Share());
      }),
      text: 'Share',
    );
  }

  Widget _buildSystemShareButton(BuildContext context) {
    return RoundIconButton(
      color: Theme.of(context).primaryColor,
      icon: Icons.share,
      onTap: () => context
          .repository<ShareService>()
          .share(
              threadId: feedUIModel.feedEntity.id,
              data:
                  '${feedUIModel.feedEntity.title}\n${feedUIModel.feedEntity.link}',
              contentType: 'news_feed')
          .then((value) {
        context.bloc<shareBloc.ShareBloc>().add(shareBloc.Share());
      }),
      text: 'Share',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Heading(title: 'Share news'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLikeButton(context),
              Container(height: 42, child: VerticalDivider()),
              _buildFacebookShareButton(context),
              _buildTwitterShareButton(context),
              _buildSystemShareButton(context),
            ],
          ),
        ],
      ),
    );
  }
}
