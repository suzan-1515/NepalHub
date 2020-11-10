import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_report/presentation/ui/report.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsFeedMoreOption extends StatelessWidget {
  final BuildContext context;

  const NewsFeedMoreOption({
    Key key,
    @required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(this.context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              visualDensity: VisualDensity.compact,
              title: Text(
                '${feed.entity.source.title}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: SourceFollowButton(context: this.context)),
          Divider(),
          BookmarkButton(
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
                      threadId: feed.entity.id,
                      data: feed.entity.link,
                      contentType: 'news_feed')
                  .then((value) {
                this.context.read<ShareBloc>().add(Share(feed: feed.entity));
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
              'Browse ${feed.entity.source.title}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
              GetIt.I.get<NavigationService>().toNewsSourceFeedScreen(
                  sourceUIModel: feed.entity.source.toUIModel,
                  context: context);
            },
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: Icon(
              Icons.remove_circle_outline,
              size: 18,
            ),
            title: Text(
              'Block ${feed.entity.source.title}',
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
              this
                  .context
                  .read<DislikeBloc>()
                  .add(DislikeEvent(feed: feed.entity));
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
                  threadId: feed.entity.id,
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
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(this.context);
    return OutlineButton.icon(
      icon: Icon(
        feed.entity.source.isFollowed ? Icons.check : Icons.add,
        size: 16,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(12),
        right: Radius.circular(12),
      )),
      visualDensity: VisualDensity.compact,
      onPressed: () {
        if (feed.entity.source.isFollowed) {
          feed.unFollowSource();
          this
              .context
              .read<SourceFollowUnFollowBloc>()
              .add(SourceUnFollowEvent(source: feed.entity.source));
        } else {
          feed.followSource();
          this
              .context
              .read<SourceFollowUnFollowBloc>()
              .add(SourceFollowEvent(source: feed.entity.source));
        }
        Navigator.pop(context);
      },
      label: Text(feed.entity.source.isFollowed ? 'Following' : 'Follow'),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(this.context);
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(
        Icons.save_alt,
        size: 18,
      ),
      title: Text(
        feed.entity.isBookmarked ? 'Remove bookmark' : 'Bookmark',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: () {
        if (feed.entity.isBookmarked) {
          feed.unBookmark();
          this
              .context
              .read<BookmarkUnBookmarkBloc>()
              .add(UnBookmarkNews(feed: feed.entity));
        } else {
          feed.bookmark();
          this
              .context
              .read<BookmarkUnBookmarkBloc>()
              .add(BookmarkNews(feed: feed.entity));
        }
        Navigator.pop(context);
      },
    );
  }
}
