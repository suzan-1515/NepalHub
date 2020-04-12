import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/routes/home/widgets/article_image_widget.dart';
import 'package:samachar_hub/routes/home/widgets/article_info_widget.dart';

class NewsThumbnailView extends StatelessWidget {
  NewsThumbnailView(this.article);

  final Feed article;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 160),
                  child: ArticleImageWidget(article.image,tag: article.id),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ArticleInfoWidget(article),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
