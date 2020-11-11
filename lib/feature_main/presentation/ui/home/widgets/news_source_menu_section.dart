import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/news_source_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/sources_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsSourceMenuSection extends StatefulWidget {
  const NewsSourceMenuSection({
    Key key,
    @required this.newsSources,
  }) : super(key: key);

  final List<NewsSourceUIModel> newsSources;

  @override
  _NewsSourceMenuSectionState createState() => _NewsSourceMenuSectionState();
}

class _NewsSourceMenuSectionState extends State<NewsSourceMenuSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Featured Sources',
          onTap: () =>
              Navigator.pushNamed(context, NewsSourcesScreen.ROUTE_NAME),
        ),
        LimitedBox(
          maxHeight: 100,
          child: Container(
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              itemExtent: 120,
              primary: false,
              itemCount: widget.newsSources.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var sourceModel = widget.newsSources[index];
                return NewsMenuItem(
                  title: sourceModel.entity.title,
                  icon: sourceModel.entity.icon,
                  onTap: () => Navigator.pushNamed(
                      context, NewsSourceFeedScreen.ROUTE_NAME,
                      arguments: sourceModel),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
