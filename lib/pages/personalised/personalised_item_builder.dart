import 'package:flutter/material.dart';
import 'package:multi_type_list_view/multi_type_list_view.dart';
import 'package:samachar_hub/data/dto/date_header.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';

class LatestFeedItemBuilder extends MultiTypeWidgetBuilder<Feed> {
  @override
  Widget buildWidget(BuildContext context, Feed item, int index) {
    Widget widget;
    if (index % 3 == 0) {
      widget = NewsThumbnailView(item);
    } else {
      widget = NewsListView(feed: item);
    }
    return widget;
  }
}

class DateHeaderItemBuilder extends MultiTypeWidgetBuilder<DateHeading> {
  @override
  Widget buildWidget(BuildContext context, DateHeading item, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        'This is a date header',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

enum MixedDataType {
  DATE_INFO,
  TRENDING_NEWS,
  LATEST_NEWS,
  NEWS_TOPIC,
  NEWS_CATEGORY,
  NEWS_SOURCE,
  FOREX,
  HOROSCOPE,
  CORONA
}
