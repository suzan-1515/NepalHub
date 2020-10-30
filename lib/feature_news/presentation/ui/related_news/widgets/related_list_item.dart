import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';

class RelatedNewsListItem extends StatelessWidget {
  final NewsFeedUIModel feedUIModel;
  final Function onTap;

  const RelatedNewsListItem({
    Key key,
    @required this.feedUIModel,
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
                  category: feedUIModel.feedEntity.category.title,
                  source: feedUIModel.newsSourceUIModel.source.title,
                  sourceIcon: feedUIModel.newsSourceUIModel.source.icon,
                  publishedDate: feedUIModel.publishedDateMomentAgo,
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
                        title: feedUIModel.feedEntity.title,
                        description: feedUIModel.feedEntity.description,
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
                          child: CachedImage(feedUIModel.feedEntity.image,
                              tag: feedUIModel.feedEntity.hashCode.toString()),
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
