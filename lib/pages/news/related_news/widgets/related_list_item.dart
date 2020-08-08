import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/pages/widgets/article_info_widget.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';

class RelatedNewsListItem extends StatelessWidget {
  final NewsFeed feed;
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
                  category: feed.category.name,
                  source: feed.source.name,
                  sourceIcon: feed.source.favicon,
                  publishedDate: feed.momentPublishedDate,
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
                          child: CachedImage(feed.image, tag: feed.tag),
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
