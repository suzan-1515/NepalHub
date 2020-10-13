import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';

class BookmarkListItem extends StatelessWidget {
  BookmarkListItem(this.feed);

  final NewsFeedUIModel feed;

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
              category: feed.feed.category.title,
              publishedDate: feed.publishedDateMomentAgo,
              source: feed.feed.source.title,
              sourceIcon: feed.feed.source.favicon,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: NewsFeedCardTitleDescription(
                    description: feed.feed.description,
                    title: feed.feed.title,
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
                      child: CachedImage(feed.feed.image, tag: feed.tag),
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.comment,
                    size: 16,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.solidBookmark,
                    size: 16,
                  ),
                  onPressed: () async {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
