import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/util/helper.dart';

class ArticleInfoWidget extends StatelessWidget {
  ArticleInfoWidget(this.article);

  final Feed article;

  String _articleSource(FeedSource source) =>
      source == null ? '' : source.name + ' • ';

  String _publishedAt(String publishedAt) => publishedAt == null
      ? ''
      : relativeTimeString(DateTime.parse(publishedAt));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          article.title,
          style: Theme.of(context).textTheme.title.copyWith(fontWeight:FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Opacity(
            opacity: 0.9,
            child: Text(
              article.description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ),
        Opacity(
          opacity: 0.75,
          child: Text(
            _articleSource(article.source) + _publishedAt(article.publishedAt),
            style: Theme.of(context).textTheme.display4,
          ),
        )
      ],
    );
  }
}
