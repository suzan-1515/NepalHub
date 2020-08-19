import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/pages/news/widgets/report_article.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/auth/auth_store.dart';

class NewsFeedMoreOption extends StatelessWidget {
  final NewsFeed feed;

  const NewsFeedMoreOption({
    Key key,
    @required this.feed,
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
              '${feed.source.name}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: OutlineButton.icon(
              icon: Icon(
                feed.source.isFollowed ? Icons.check : Icons.add,
                size: 16,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12),
                right: Radius.circular(12),
              )),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                final value = feed.source.isFollowed;
                feed.source.follow = !feed.source.isFollowed;
                if (value)
                  context
                      .read<FollowingRepository>()
                      .unFollowSource(feed.source)
                      .catchError((onError) => feed.source.follow = value);
                else
                  context
                      .read<FollowingRepository>()
                      .followSource(feed.source)
                      .catchError((onError) => feed.source.follow = value);
                Navigator.pop(context);
              },
              label: Text(feed.source.isFollowed ? 'Following' : 'Follow'),
            ),
          ),
          Divider(),
          ListTile(
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
              final value = feed.isBookmarked;
              final userId = context.read<AuthenticationStore>().user.uId;
              if (value)
                context
                    .read<BookmarkRepository>()
                    .removeBookmark(postId: feed.uuid, userId: userId)
                    .catchError((onError) => feed.bookmark = value);
              else
                context
                    .read<BookmarkRepository>()
                    .postBookmark(userId: userId, feed: feed)
                    .catchError((onError) => feed.bookmark = value);
              Navigator.pop(context);
            },
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
              final authStore = context.read<AuthenticationStore>();
              context.read<ShareService>().share(
                  postId: feed.uuid,
                  data: '${feed.title}\n${feed.link}',
                  contentType: 'news');
              if (authStore.isLoggedIn)
                context
                    .read<PostMetaRepository>()
                    .postShare(postId: feed.uuid, userId: authStore.user.uId)
                    .catchError((onError) {});
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
              'Browse ${feed.source.name}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onTap: () {
              Navigator.pop(context);
              context.read<NavigationService>().toNewsSourceFeedScreen(
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
              'Block ${feed.source.name}',
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
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.report),
            trailing: Icon(
              Icons.chevron_right,
              size: 18,
            ),
            onExpansionChanged: (value) {},
            title: Text(
              'Report',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            children: [
              ReportArticle(
                articleId: feed.uuid,
                articleType: 'news',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
