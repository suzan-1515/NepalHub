import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/author_and_bookmark.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/disclaimer.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/read_more.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/related_feeds.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/share.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/source.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({
    Key key,
    @required this.context,
    @required this.feedUIModel,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedUIModel feedUIModel;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Text(
              feedUIModel.feedEntity.title,
              style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w600), //Todo: Use proper style
            ),
            SizedBox(
              height: 16,
            ),
            Source(
              context: context,
              feedUIModel: feedUIModel,
            ),
            SizedBox(
              height: 16,
            ),
            AuthorAndBookmark(
              feedUIModel: feedUIModel,
              context: context,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              feedUIModel.feedEntity.description ??
                  'Article content not available.',
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(height: 1.5),
            ),
            // _buildAdRow(),
            ReadMore(context: context, feedUIModel: feedUIModel),
            SizedBox(height: 8),
            Divider(),
            Share(
              feedUIModel: feedUIModel,
            ),
            SizedBox(height: 16),
            Disclaimer(feedUIModel: feedUIModel),
            RelatedNews(
              feedUIModel: feedUIModel,
            ),
          ],
        ),
      ),
    );
  }
}
