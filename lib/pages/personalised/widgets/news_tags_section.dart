import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';

class NewsTagsSection extends StatelessWidget {
  final NewsTags item;
  const NewsTagsSection({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationService>(
        builder: (context, navigationService, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SectionHeadingView(
            title: 'Trending Topics',
            subtitle: 'Get the latest news on currently trending topics',
            onTap: () {},
          ),
          Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List<Widget>.generate(
                  item.tags.length,
                  (index) => NewsTagItem(
                        title: item.tags[index],
                        onTap: (tag) => navigationService.onNewsTagTapped(
                            title: tag, context: context),
                      )),
            ),
          ),
        ],
      );
    });
  }
}
