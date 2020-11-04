import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/widgets/news_source_list_item.dart';

class NewsSourceListBuilder extends StatelessWidget {
  const NewsSourceListBuilder({
    Key key,
    @required this.data,
    @required this.onRefresh,
  }) : super(key: key);

  final List<NewsSourceEntity> data;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FadeInUp(
        duration: Duration(milliseconds: 200),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: data.length,
          itemBuilder: (context, index) =>
              NewsSourceListItem(source: data[index]),
          separatorBuilder: (_, int index) => Divider(),
        ),
      ),
    );
  }
}
