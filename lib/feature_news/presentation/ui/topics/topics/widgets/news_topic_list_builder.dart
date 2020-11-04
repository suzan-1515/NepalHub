import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/widgets/news_topic_list_item.dart';

class NewsTopicListBuilder extends StatelessWidget {
  const NewsTopicListBuilder({
    Key key,
    @required this.data,
    @required this.onRefresh,
  }) : super(key: key);

  final List<NewsTopicEntity> data;
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
              NewsTopicListItem(topic: data[index]),
          separatorBuilder: (_, int index) => Divider(),
        ),
      ),
    );
  }
}
