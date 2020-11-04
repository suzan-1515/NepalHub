import 'package:animate_do/animate_do.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart'
    as shareBloc;
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/round_button.dart';

class Share extends StatelessWidget {
  final NewsFeedEntity feed;

  const Share({Key key, this.feed}) : super(key: key);

  Widget _buildFacebookShareButton(BuildContext context) {
    return RoundIconButton(
      color: Color.fromARGB(255, 66, 103, 178),
      icon: FontAwesomeIcons.facebookF,
      onTap: () => GetIt.I
          .get<ShareService>()
          .shareToFacebook(
              threadId: feed.id,
              title: feed.title,
              url: feed.link,
              contentType: 'news_feed')
          .then((value) {
        context.bloc<shareBloc.ShareBloc>().add(shareBloc.Share(feed: feed));
      }),
      text: 'Share',
    );
  }

  Widget _buildTwitterShareButton(BuildContext context) {
    return RoundIconButton(
      color: Color.fromARGB(255, 29, 161, 242),
      icon: FontAwesomeIcons.twitter,
      onTap: () => GetIt.I
          .get<ShareService>()
          .shareToTwitter(
              threadId: feed.id,
              title: feed.title,
              url: feed.link,
              contentType: 'news_feed')
          .then((value) {
        context.bloc<shareBloc.ShareBloc>().add(shareBloc.Share(feed: feed));
      }),
      text: 'Share',
    );
  }

  Widget _buildSystemShareButton(BuildContext context) {
    return RoundIconButton(
      color: Theme.of(context).primaryColor,
      icon: Icons.share,
      onTap: () => GetIt.I
          .get<ShareService>()
          .share(
              threadId: feed.id,
              data: '${feed.title}\n${feed.link}',
              contentType: 'news_feed')
          .then((value) {
        context.bloc<shareBloc.ShareBloc>().add(shareBloc.Share(feed: feed));
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
              LikeButton(
                context: context,
                feed: feed,
              ),
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

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key key,
    @required this.context,
    @required this.feed,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return RoundIconButton(
      color: Theme.of(context).accentColor.withOpacity(0.7),
      icon: feed.isLiked
          ? FontAwesomeIcons.solidThumbsUp
          : FontAwesomeIcons.thumbsUp,
      onTap: () {
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
      text: feed.likeCount == 0 ? 'Like' : '${feed.likeCount.compactFormat}',
    );
  }
}
