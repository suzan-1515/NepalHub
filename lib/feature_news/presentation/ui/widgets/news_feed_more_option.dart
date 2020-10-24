import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/report_article.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsFeedMoreOption extends StatelessWidget {
  final NewsFeedUIModel feed;
  final BuildContext context;

  const NewsFeedMoreOption({
    Key key,
    @required this.feed,
    @required this.context,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              '${feed.newsSourceUIModel.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
                cubit: this.context.bloc<FollowUnFollowBloc>(),
                builder: (context, state) {
                  return OutlineButton.icon(
                    icon: state is FollowUnFollowInProgressState
                        ? Icon(
                            Icons.donut_large,
                            color: Theme.of(context).accentColor,
                            size: 16,
                          )
                        : Icon(
                            feed.newsSourceUIModel.source.isFollowed
                                ? Icons.check
                                : Icons.add,
                            size: 16,
                          ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(12),
                      right: Radius.circular(12),
                    )),
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      if (feed.newsSourceUIModel.source.isFollowed) {
                        feed.newsSourceUIModel.unfollow();
                        this
                            .context
                            .bloc<FollowUnFollowBloc>()
                            .add(FollowUnFollowUnFollowEvent());
                      } else {
                        feed.newsSourceUIModel.follow();
                        this
                            .context
                            .bloc<FollowUnFollowBloc>()
                            .add(FollowUnFollowFollowEvent());
                      }
                      Navigator.pop(context);
                    },
                    label: Text(feed.newsSourceUIModel.source.isFollowed
                        ? 'Following'
                        : 'Follow'),
                  );
                }),
          ),
          Divider(),
          BlocBuilder<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
              cubit: this.context.bloc<BookmarkUnBookmarkBloc>(),
              builder: (context, state) {
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: Icon(
                    Icons.save_alt,
                    size: 18,
                  ),
                  title: Text(
                    feed.feedEntity.isBookmarked
                        ? 'Remove bookmark'
                        : 'Bookmark',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: state is BookmarkInProgress
                      ? Icon(
                          Icons.donut_large,
                          color: Theme.of(context).accentColor,
                          size: 16,
                        )
                      : null,
                  onTap: () {
                    if (feed.feedEntity.isBookmarked) {
                      feed.unbookmark();
                      this
                          .context
                          .bloc<BookmarkUnBookmarkBloc>()
                          .add(UnBookmarkNews());
                    } else {
                      feed.bookmark();
                      this
                          .context
                          .bloc<BookmarkUnBookmarkBloc>()
                          .add(BookmarkNews());
                    }
                    Navigator.pop(context);
                  },
                );
              }),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.share,
              size: 18,
            ),
            title: Text(
              'Share',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              GetIt.I
                  .get<ShareService>()
                  .share(
                      threadId: feed.feedEntity.id,
                      data: feed.feedEntity.link,
                      contentType: 'news_feed')
                  .then((value) {
                this.context.bloc<ShareBloc>().add(Share());
                return value;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.open_in_browser,
              size: 18,
            ),
            title: Text(
              'Browse ${feed.newsSourceUIModel.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
              GetIt.I.get<NavigationService>().toNewsSourceFeedScreen(
                  source: feed.newsSourceUIModel.source, context: context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.remove_circle_outline,
              size: 18,
            ),
            title: Text(
              'Block ${feed.newsSourceUIModel.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.thumb_down,
              size: 18,
            ),
            title: Text(
              'Show less of such content',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              this.context.bloc<DislikeBloc>().add(DislikeEvent());
              Navigator.pop(context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.report,
              size: 18,
            ),
            title: Text(
              'Report',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              // Navigator.pop(context);
              context.showBottomSheet(
                child: ReportArticle(
                  articleId: feed.feedEntity.id,
                  articleType: 'news',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
