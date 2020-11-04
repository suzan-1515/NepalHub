import 'package:animate_do/animate_do.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/core/extensions/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorAndBookmark extends StatelessWidget {
  const AuthorAndBookmark({
    Key key,
    @required this.feed,
    @required this.context,
  }) : super(key: key);

  final NewsFeedEntity feed;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidUserCircle),
        SizedBox(width: 6),
        RichText(
          text: TextSpan(
            text: 'By ${feed.source.title}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                text: '\n${feed.publishedDate.momentAgo}',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                NewsBookmarkButton(feed: feed),
                const SizedBox(height: 4),
                Text('Bookmark', textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NewsBookmarkButton extends StatelessWidget {
  const NewsBookmarkButton({
    Key key,
    @required this.feed,
  }) : super(key: key);

  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        feed.isBookmarked
            ? FontAwesomeIcons.solidHeart
            : FontAwesomeIcons.heart,
        size: 36,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        if (feed.isBookmarked) {
          context
              .bloc<BookmarkUnBookmarkBloc>()
              .add(UnBookmarkNews(feed: feed));
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: feed, eventType: 'unbookmark'));
        } else {
          context.bloc<BookmarkUnBookmarkBloc>().add(BookmarkNews(feed: feed));
          GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                data: feed,
                eventType: 'bookmark',
              ));
        }
      },
    );
  }
}
