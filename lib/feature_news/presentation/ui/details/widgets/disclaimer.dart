import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/presentation/ui/report.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:scoped_model/scoped_model.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
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
                    threadId: feed.entity.id,
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
                          'This story is auto-aggregated by a computer program and has not been created or edited by Nepal Hub.\nPublisher: ${feed.entity.source.title}',
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
