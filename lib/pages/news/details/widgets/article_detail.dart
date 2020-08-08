import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/news/details/widgets/author_and_category.dart';
import 'package:samachar_hub/pages/news/details/widgets/read_more.dart';
import 'package:samachar_hub/pages/news/details/widgets/related_feeds.dart';
import 'package:samachar_hub/pages/news/details/widgets/source_and_bookmark.dart';
import 'package:samachar_hub/stores/news/detail/news_detail_store.dart';
import 'package:samachar_hub/stores/stores.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({
    Key key,
    @required this.context,
    @required this.store,
    @required this.metaStore,
  }) : super(key: key);

  final BuildContext context;
  final NewsDetailStore store;
  final PostMetaStore metaStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            store.feed.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w600), //Todo: Use proper style
          ),
          SizedBox(
            height: 16,
          ),
          SourceAndBookmark(
            context: context,
            store: store,
            metaStore: metaStore,
          ),
          SizedBox(
            height: 16,
          ),
          AuthorAndCategory(
            store: store,
            context: context,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            store.feed.description ?? 'No article content available.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          // _buildAdRow(),
          ReadMore(context: context, store: store),
          if (store.hasRelatedFeeds)
            RelatedNews(
              store: store,
            ),
        ],
      ),
    );
  }
}
