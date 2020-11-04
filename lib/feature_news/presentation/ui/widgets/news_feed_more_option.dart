import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/presentation/ui/report.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsFeedMoreOption extends StatelessWidget {
  final NewsFeedEntity feed;
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
                '${feed.source.title}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: SourceFollowButton(
                  source: feed.source, context: this.context)),
          Divider(),
          BookmarkButton(
            feed: feed,
            context: this.context,
          ),
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
                      threadId: feed.id,
                      data: feed.link,
                      contentType: 'news_feed')
                  .then((value) {
                this.context.bloc<ShareBloc>().add(Share(feed: feed));
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
              'Browse ${feed.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
              GetIt.I.get<NavigationService>().toNewsSourceFeedScreen(
                  source: feed.source, context: context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.remove_circle_outline,
              size: 18,
            ),
            title: Text(
              'Block ${feed.source.title}',
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
              this.context.bloc<DislikeBloc>().add(DislikeEvent(feed: feed));
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
                child: Report(
                  threadId: feed.id,
                  threadType: ReportThreadType.NEWS_FEED,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SourceFollowButton extends StatelessWidget {
  const SourceFollowButton({
    Key key,
    @required this.source,
    @required this.context,
  }) : super(key: key);

  final NewsSourceEntity source;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      icon: Icon(
        source.isFollowed ? Icons.check : Icons.add,
        size: 16,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(12),
        right: Radius.circular(12),
      )),
      visualDensity: VisualDensity.compact,
      onPressed: () {
        if (source.isFollowed) {
          GetIt.I.get<EventBus>().fire(
              NewsChangeEvent(data: source, eventType: 'source_unfollow'));
          this
              .context
              .bloc<SourceFollowUnFollowBloc>()
              .add(SourceUnFollowEvent(source: source));
        } else {
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: source, eventType: 'source_follow'));
          this
              .context
              .bloc<SourceFollowUnFollowBloc>()
              .add(SourceFollowEvent(source: source));
        }
        Navigator.pop(context);
      },
      label: Text(source.isFollowed ? 'Following' : 'Follow'),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    Key key,
    @required this.feed,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(
        Icons.save_alt,
        size: 18,
      ),
      title: Text(
        feed.isBookmarked ? 'Remove bookmark' : 'Bookmark',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: () {
        if (feed.isBookmarked) {
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: feed, eventType: 'unbookmark'));
          this
              .context
              .bloc<BookmarkUnBookmarkBloc>()
              .add(UnBookmarkNews(feed: feed));
        } else {
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: feed, eventType: 'bookmark'));
          this
              .context
              .bloc<BookmarkUnBookmarkBloc>()
              .add(BookmarkNews(feed: feed));
        }
        Navigator.pop(context);
      },
    );
  }
}
