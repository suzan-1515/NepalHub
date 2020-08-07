import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/article_info_widget.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/news/bookmark/bookmark_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';

class BookmarkListItem extends StatelessWidget {
  BookmarkListItem(this.feed);

  final NewsFeed feed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NewsFeedCardSourceCategory(
              category: feed.category.name,
              publishedDate: feed.momentPublishedDate,
              source: feed.source.name,
              sourceIcon: feed.source.favicon,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: NewsFeedCardTitleDescription(
                    description: feed.description,
                    title: feed.title,
                  ),
                ),
                SizedBox(
                  width: 8,
                  height: 8,
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: CachedImage(feed.image, tag: feed.tag),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.shareAlt,
                    size: 16,
                  ),
                  onPressed: () {
                    context.read<ShareService>().share(
                          postId: feed.uuid,
                          title: feed.title,
                          data: feed.link,
                        );
                    final authStore = context.read<AuthenticationStore>();
                    if (authStore.isLoggedIn)
                      context.read<PostMetaRepository>().postShare(
                            postId: feed.uuid,
                            userId: authStore.user.uId,
                          );
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.comment,
                    size: 16,
                  ),
                  onPressed: () {
                    context.read<NavigationService>().toCommentsScreen(
                          context: context,
                          title: feed.title,
                          postId: feed.uuid,
                        );
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.solidBookmark,
                    size: 16,
                  ),
                  onPressed: () async {
                    context
                        .read<BookmarkStore>()
                        .removeBookmarkedFeed(feed: feed)
                        .then((onValue) =>
                            feed.bookmarkNotifier.value = !onValue);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
