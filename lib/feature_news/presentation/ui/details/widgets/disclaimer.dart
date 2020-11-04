import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/presentation/ui/report.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class Disclaimer extends StatelessWidget {
  final NewsFeedEntity feed;

  const Disclaimer({Key key, this.feed}) : super(key: key);
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
                  child: Report(
                    threadId: feed.id,
                    threadType: ReportThreadType.NEWS_FEED,
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
                          'This story is auto-aggregated by a computer program and has not been created or edited by Nepal Hub.\nPublisher: ${feed.source.title}',
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
