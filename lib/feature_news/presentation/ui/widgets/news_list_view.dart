import 'package:flutter/material.dart';
import 'package:samachar_hub/core/extensions/date_time.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsListView extends StatelessWidget {
  const NewsListView();

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, NewsDetailScreen.ROUTE_NAME,
            arguments: feed),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NewsFeedCardSourceCategory(
                category: feed.entity.category.title,
                publishedDate: feed.entity.publishedDate.momentAgo,
                source: feed.entity.source.title,
                sourceIcon: feed.entity.source.favicon,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: NewsFeedCardTitleDescription(
                      description: feed.entity.description,
                      title: feed.entity.title,
                      descriptionMaxLines: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 4,
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
                        child: CachedImage(feed.entity.image,
                            tag: '${feed.entity.id}-${feed.entity.type}'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const NewsFeedOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
