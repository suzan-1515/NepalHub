import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/news_source_menu_item.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class NewsSourceMenuSection extends StatelessWidget {
  final List<NewsSource> items;
  const NewsSourceMenuSection({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeStore, NavigationService>(
        builder: (context, homeScreenStore, navigationService, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SectionHeading(
            title: 'News Sources',
            subtitle: 'Explore news from your favourite news sources',
            onTap: () => navigationService.toFavouriteNewsSourceScreen(context),
          ),
          LimitedBox(
            maxHeight: 100,
            child: Container(
              color: Theme.of(context).cardColor,
              child: ListView.builder(
                  itemExtent: 120,
                  itemCount: items.length,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NewsSourceMenuItem(
                      source: items[index],
                      onTap: (sourceMenu) =>
                          navigationService.toNewsSourceFeedScreen(
                        source: sourceMenu,
                        context: context,
                        sources: items,
                      ),
                    );
                  }),
            ),
          ),
        ],
      );
    });
  }
}