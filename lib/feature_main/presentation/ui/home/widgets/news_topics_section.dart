import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_tag_item.dart';

class NewsTopicsSection extends StatelessWidget {
  final List<NewsTopicUIModel> items;
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
          subtitle: 'Get the latest news on currently trending topics',
        ),
        Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: items
                .map((e) => NewsTagItem(
                      title: e.topic.title,
                      onTap: (value) => context
                          .repository<NavigationService>()
                          .toNewsTopicFeedScreen(
                              context: context, topicEntity: e.topic),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
