import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';
import 'package:samachar_hub/widgets/article_info_widget.dart';

class NewsThumbnailView extends StatelessWidget {
  NewsThumbnailView(this.article);

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FeedSourceSection(article),
            SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                child: ArticleImageWidget(article.image,
                    tag: article.uuid + article.id),
              ),
            ),
            SizedBox(height: 8),
            FeedTitleDescriptionSection(article),
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
