import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorAndBookmark extends StatelessWidget {
  const AuthorAndBookmark({
    Key key,
    @required this.feedUIModel,
    @required this.context,
  }) : super(key: key);

  final NewsFeedUIModel feedUIModel;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidUserCircle),
        SizedBox(width: 6),
        RichText(
          text: TextSpan(
            text: 'By ${feedUIModel.feed.author}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                text: '\n${feedUIModel.publishedDateMomentAgo}',
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
                BlocConsumer<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is BookmarkSuccess) {
                      feedUIModel.bookmark();
                    } else if (state is UnbookmarkSuccess) {
                      feedUIModel.unbookmark();
                    }
                    return IconButton(
                      icon: Icon(
                        feedUIModel.feed.isBookmarked
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        size: 36,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        if (feedUIModel.feed.isBookmarked) {
                          feedUIModel.unbookmark();
                          context
                              .bloc<BookmarkUnBookmarkBloc>()
                              .add(UnBookmarkNews());
                        } else {
                          feedUIModel.unbookmark();
                          context
                              .bloc<BookmarkUnBookmarkBloc>()
                              .add(BookmarkNews());
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 4),
                Text('Bookmark', textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
