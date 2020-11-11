import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/news_topic_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/topics_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_tag_item.dart';

class NewsTopicsSection extends StatefulWidget {
  final List<NewsTopicUIModel> items;
  const NewsTopicsSection({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  _NewsTopicsSectionState createState() => _NewsTopicsSectionState();
}

class _NewsTopicsSectionState extends State<NewsTopicsSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Trending Topics',
          onTap: () =>
              Navigator.pushNamed(context, NewsTopicsScreen.ROUTE_NAME),
        ),
        Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: widget.items
                .map((e) => NewsTagItem(
                      title: e.entity.title,
                      icon: e.entity.icon,
                      onTap: (value) => Navigator.pushNamed(
                          context, NewsTopicFeedScreen.ROUTE_NAME,
                          arguments: e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
