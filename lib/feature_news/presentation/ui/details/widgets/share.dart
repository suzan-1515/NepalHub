import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart'
    as shareBloc;
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/round_button.dart';
import 'package:scoped_model/scoped_model.dart';

class Share extends StatelessWidget {
  const Share({Key key}) : super(key: key);

  Widget _buildFacebookShareButton(BuildContext context, NewsFeedUIModel feed) {
    return RoundIconButton(
      color: Color.fromARGB(255, 66, 103, 178),
      icon: FontAwesomeIcons.facebookF,
      onTap: () => GetIt.I
          .get<ShareService>()
          .shareToFacebook(
              threadId: feed.entity.id,
              title: feed.entity.title,
              url: feed.entity.link,
              contentType: 'news_feed')
          .then((value) {
        context
            .read<shareBloc.ShareBloc>()
            .add(shareBloc.Share(feed: feed.entity));
      }),
      text: 'Share',
    );
  }

  Widget _buildTwitterShareButton(BuildContext context, NewsFeedUIModel feed) {
    return RoundIconButton(
      color: Color.fromARGB(255, 29, 161, 242),
      icon: FontAwesomeIcons.twitter,
      onTap: () => GetIt.I
          .get<ShareService>()
          .shareToTwitter(
              threadId: feed.entity.id,
              title: feed.entity.title,
              url: feed.entity.link,
              contentType: 'news_feed')
          .then((value) {
        context
            .read<shareBloc.ShareBloc>()
            .add(shareBloc.Share(feed: feed.entity));
      }),
      text: 'Share',
    );
  }

  Widget _buildSystemShareButton(BuildContext context, NewsFeedUIModel feed) {
    return RoundIconButton(
      color: Theme.of(context).primaryColor,
      icon: Icons.share,
      onTap: () => GetIt.I
          .get<ShareService>()
          .share(
              threadId: feed.entity.id,
              data: '${feed.entity.title}\n${feed.entity.link}',
              contentType: 'news_feed')
          .then((value) {
        context
            .read<shareBloc.ShareBloc>()
            .add(shareBloc.Share(feed: feed.entity));
      }),
      text: 'Share',
    );
  }

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
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
              const LikeButton(),
              Container(height: 42, child: const VerticalDivider()),
              _buildFacebookShareButton(context, feed),
              _buildTwitterShareButton(context, feed),
              _buildSystemShareButton(context, feed),
            ],
          ),
        ],
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed =
        ScopedModel.of<NewsFeedUIModel>(context, rebuildOnChange: true);
    return RoundIconButton(
      color: Theme.of(context).accentColor.withOpacity(0.7),
      icon: feed.entity.isLiked
          ? FontAwesomeIcons.solidThumbsUp
          : FontAwesomeIcons.thumbsUp,
      onTap: () {
        if (feed.entity.isLiked) {
          feed.unLike();
          context.read<LikeUnlikeBloc>().add(UnlikeEvent(feed: feed.entity));
        } else {
          feed.like();
          context.read<LikeUnlikeBloc>().add(LikeEvent(feed: feed.entity));
        }
      },
      text: feed.entity.likeCount == 0
          ? 'Like'
          : '${feed.entity.likeCount.compactFormat}',
    );
  }
}
