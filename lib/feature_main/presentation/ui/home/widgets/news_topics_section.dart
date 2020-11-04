import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_tag_item.dart';

class NewsTopicsSection extends StatelessWidget {
  final List<NewsTopicEntity> items;
  const NewsTopicsSection({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Trending Topics',
        ),
        Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: items
                .map((e) => NewsTagItem(
                      title: e.title,
                      icon: e.icon,
                      onTap: (value) => GetIt.I
                          .get<NavigationService>()
                          .toNewsTopicFeedScreen(context: context, topic: e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
