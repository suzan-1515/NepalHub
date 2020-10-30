import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';

class NewsThumbnailView extends StatelessWidget {
  final NewsFeedUIModel feedUIModel;
  NewsThumbnailView({@required this.feedUIModel});

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
        onTap: () => NewsDetailScreen.navigate(feedUIModel.feedEntity, context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              NewsFeedCardSourceCategory(
                category: feedUIModel.feedEntity.category.title,
                publishedDate: feedUIModel.publishedDateMomentAgo,
                source: feedUIModel.newsSourceUIModel.source.title,
                sourceIcon: feedUIModel.newsSourceUIModel.source.favicon,
              ),
              SizedBox(height: 8),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: CachedImage(
                    feedUIModel.feedEntity.image,
                    tag: feedUIModel.feedEntity.hashCode.toString(),
                  ),
                ),
              ),
              SizedBox(height: 8),
              NewsFeedCardTitleDescription(
                description: feedUIModel.feedEntity.description,
                title: feedUIModel.feedEntity.title,
                descriptionMaxLines:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2
                        : 4,
              ),
              SizedBox(height: 8),
              Divider(),
              NewsFeedOptions(feedUIModel: feedUIModel),
            ],
          ),
        ),
      ),
    );
  }
}
