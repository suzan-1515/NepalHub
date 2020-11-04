import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/date_time.dart';

class RelatedNewsListItem extends StatelessWidget {
  final NewsFeedEntity feed;
  final Function onTap;

  const RelatedNewsListItem({
    Key key,
    @required this.feed,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NewsFeedCardSourceCategory(
                  category: feed.category.title,
                  source: feed.source.title,
                  sourceIcon: feed.source.icon,
                  publishedDate: feed.publishedDate.momentAgo,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: NewsFeedCardTitleDescription(
                        title: feed.title,
                        description: feed.description,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: CachedImage(feed.image, tag: feed.id),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
