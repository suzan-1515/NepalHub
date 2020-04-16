import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/routes/home/widgets/article_image_widget.dart';
import 'package:samachar_hub/routes/home/widgets/article_info_widget.dart';

class NewsListView extends StatelessWidget {
  NewsListView(this.article);

  final Feed article;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FeedSourceSection(article),
            SizedBox(height: 8),
            IntrinsicHeight(
                          child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: FeedTitleDescriptionSection(article),
                  ),
                  SizedBox(
                    width: 8,
                    height: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: ArticleImageWidget(article.image,
                          tag: article.uuid + article.id),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            FeedOptionsSection(
              article: article,
            ),
          ],
        ),
      ),
    );
  }
}
