import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';

class NewsTopicsSection extends StatelessWidget {
  final List<NewsTopic> items;
  final Function(NewsTopic) onTap;
  const NewsTopicsSection({
    Key key,
    this.items,
    this.onTap,
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
                      title: e.title,
                      onTap: (value) => this.onTap(e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
