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
  final BuildContext context;

  const Share({Key key, this.feedUIModel, this.context}) : super(key: key);

  Widget _buildLikeButton() {
    return BlocConsumer<LikeUnlikeBloc, LikeUnlikeState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
            current is InitialState ||
            current is InProgressState ||
            current is LikedState ||
            current is UnlikedState,
        builder: (context, state) {
          if (state is LikedState) {
            feedUIModel.like();
          } else if (state is UnlikedState) {
            feedUIModel.unlike();
          }
          return RoundIconButton(
            color: Theme.of(context).accentColor.withOpacity(0.7),
            icon: feedUIModel.feed.isLiked
                ? FontAwesomeIcons.solidThumbsUp
                : FontAwesomeIcons.thumbsUp,
            onTap: () {
              if (feedUIModel.feed.isLiked) {
                feedUIModel.unlike();
                context
                    .bloc<LikeUnlikeBloc>()
                    .add(UnlikeEvent(feedModel: feedUIModel));
              } else {
                feedUIModel.like();
                context
                    .bloc<LikeUnlikeBloc>()
                    .add(LikeEvent(feedModel: feedUIModel));
              }
            },
            text: feedUIModel.feed.likeCount == 0
                ? 'Like'
                : '${feedUIModel.formattedLikeCount}',
          );
        });
  }

  Widget _buildFacebookShareButton() {
    return RoundIconButton(
      color: Color.fromARGB(255, 66, 103, 178),
      icon: FontAwesomeIcons.facebookF,
      onTap: () => context
          .repository<ShareService>()
          .shareToFacebook(
              threadId: feedUIModel.feed.id,
              title: feedUIModel.feed.title,
              url: feedUIModel.feed.link,
              contentType: 'news_feed')
          .then((value) {
        context
            .bloc<shareBloc.ShareBloc>()
            .add(shareBloc.Share(feedModel: feedUIModel));
      }),
      text: 'Share',
    );
  }

  Widget _buildTwitterShareButton() {
    return RoundIconButton(
      color: Color.fromARGB(255, 29, 161, 242),
      icon: FontAwesomeIcons.twitter,
      onTap: () => context
          .repository<ShareService>()
          .shareToTwitter(
              threadId: feedUIModel.feed.id,
              title: feedUIModel.feed.title,
              url: feedUIModel.feed.link,
              contentType: 'news_feed')
          .then((value) {
        context
            .bloc<shareBloc.ShareBloc>()
            .add(shareBloc.Share(feedModel: feedUIModel));
      }),
      text: 'Share',
    );
  }

  Widget _buildSystemShareButton() {
    return RoundIconButton(
      color: Theme.of(context).primaryColor,
      icon: Icons.share,
      onTap: () => context
          .repository<ShareService>()
          .share(
              threadId: feedUIModel.feed.id,
              data: '${feedUIModel.feed.title}\n${feedUIModel.feed.link}',
              contentType: 'news_feed')
          .then((value) {
        context
            .bloc<shareBloc.ShareBloc>()
            .add(shareBloc.Share(feedModel: feedUIModel));
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
              _buildLikeButton(),
              Container(height: 42, child: VerticalDivider()),
              _buildFacebookShareButton(),
              _buildTwitterShareButton(),
              _buildSystemShareButton(),
            ],
          ),
        ],
      ),
    );
  }
}
