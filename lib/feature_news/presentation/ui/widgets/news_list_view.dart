import 'package:flutter/material.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/article_info_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';

class NewsListView extends StatelessWidget {
  final NewsFeedUIModel feedUIModel;

  NewsListView({@required this.feedUIModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => context
            .repository<NavigationService>()
            .toFeedDetail(feedUIModel, context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NewsFeedCardSourceCategory(
                category: feedUIModel.feed.category.title,
                publishedDate: feedUIModel.publishedDateMomentAgo,
                source: feedUIModel.feed.source.title,
                sourceIcon: feedUIModel.feed.source.favicon,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: NewsFeedCardTitleDescription(
                      description: feedUIModel.feed.description,
                      title: feedUIModel.feed.title,
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
                        child: CachedImage(feedUIModel.feed.image,
                            tag: feedUIModel.tag),
                      ),
                    ),
                  ),
                ],
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
