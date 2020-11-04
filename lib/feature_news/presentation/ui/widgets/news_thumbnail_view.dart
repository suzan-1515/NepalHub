import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/date_time.dart';

class NewsThumbnailView extends StatelessWidget {
  final NewsFeedEntity feed;
  NewsThumbnailView({@required this.feed});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => NewsDetailScreen.navigate(feed, context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              NewsFeedCardSourceCategory(
                category: feed.category.title,
                publishedDate: feed.publishedDate.momentAgo,
                source: feed.source.title,
                sourceIcon: feed.source.favicon,
              ),
              SizedBox(height: 8),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: CachedImage(
                    feed.image,
                    tag: '${feed.id}-${feed.type}',
                  ),
                ),
              ),
              SizedBox(height: 8),
              NewsFeedCardTitleDescription(
                description: feed.description,
                title: feed.title,
                descriptionMaxLines:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2
                        : 4,
              ),
              SizedBox(height: 8),
              Divider(),
              NewsFeedOptions(feed: feed),
            ],
          ),
        ),
      ),
    );
  }
}
