import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/core/extensions/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthorAndBookmark extends StatelessWidget {
  const AuthorAndBookmark({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
    return Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidUserCircle),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            text: 'By ${feed.entity.source.title}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                text: '\n${feed.entity.publishedDate.momentAgo}',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
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
                const NewsBookmarkButton(),
                const SizedBox(height: 4),
                const Text('Bookmark', textAlign: TextAlign.center)
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed =
        ScopedModel.of<NewsFeedUIModel>(context, rebuildOnChange: true);
    return IconButton(
      icon: Icon(
        feed.entity.isBookmarked
            ? FontAwesomeIcons.solidHeart
            : FontAwesomeIcons.heart,
        size: 36,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        if (feed.entity.isBookmarked) {
          feed.unBookmark();
          context
              .read<BookmarkUnBookmarkBloc>()
              .add(UnBookmarkNews(feed: feed.entity));
        } else {
          feed.bookmark();
          context
              .read<BookmarkUnBookmarkBloc>()
              .add(BookmarkNews(feed: feed.entity));
        }
      },
    );
  }
}
