import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/feed.dart';

import 'article_image_widget.dart';
import 'article_info_widget.dart';

class NewsCompactView extends StatelessWidget {
  NewsCompactView(this.article);

  final Feed article;

  @override
  Widget build(BuildContext context) {
    // Todo: Not what I had in mind!
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ArticleImageWidget(article.image,tag: article.uuid+article.id),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.black12,
                    Colors.white54,
                    Colors.white60,
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ArticleInfoWidget(article),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
