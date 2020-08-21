import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/news/widgets/report_article.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class Disclaimer extends StatelessWidget {
  final NewsDetailStore store;

  const Disclaimer({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fontStyle =
        Theme.of(context).textTheme.caption.copyWith(fontSize: 11, height: 2);
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nepal Hub',
                style: fontStyle,
              ),
              FlatButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => context.showBottomSheet(
                  child: ReportArticle(
                    articleId: store.feed.uuid,
                    articleType: 'news',
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.flag,
                      color: fontStyle.color,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'Report',
                      style: fontStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          Flexible(
            child: RichText(
              softWrap: true,
              text: TextSpan(
                text: 'Disclaimer: ',
                style: fontStyle.copyWith(fontStyle: FontStyle.italic),
                children: [
                  TextSpan(
                      text:
                          'This story is auto-aggregated by a computer program and has not been created or edited by Nepal Hub.\nPublisher: ${store.feed.source.name}',
                      style: fontStyle.copyWith(fontStyle: FontStyle.normal)),
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
