import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/article.dart';
import 'package:samachar_hub/routes/home/widgets/article_image_widget.dart';
import 'package:samachar_hub/routes/home/widgets/article_info_widget.dart';

class NewsListView extends StatelessWidget {
  NewsListView(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ArticleImageWidget(article.urlToImage),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ArticleInfoWidget(article),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
