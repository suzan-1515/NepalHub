import 'package:flutter/material.dart';
import 'package:multi_type_list_view/multi_type_list_view.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/data/dto/heading.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';
import 'package:samachar_hub/data/dto/progress.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/widgets/news_category_item.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class SectionHeadingItemBuilder extends MultiTypeWidgetBuilder<SectionHeading> {
  @override
  Widget buildWidget(BuildContext context, SectionHeading item, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
      child: RichText(
        text: TextSpan(
          text: item.title,
          style: Theme.of(context).textTheme.subhead,
          children: <TextSpan>[
            TextSpan(text: '\n'),
            TextSpan(
                text: item.subtitle,
                style: Theme.of(context).textTheme.subtitle)
          ],
        ),
      ),
    );
  }
}

class CategoryMenuItemBuilder
    extends MultiTypeWidgetBuilder<List<NewsCategoryMenu>> {
  @override
  Widget buildWidget(
      BuildContext context, List<NewsCategoryMenu> item, int index) {
    return Consumer<HomeScreenStore>(
        builder: (context, homeScreenStore, child) {
      return Container(
        height: 100,
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: item.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NewsCategoryMenuItem(
                      category: item[index],
                    );
                  }),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => homeScreenStore.setPage(1),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'All',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class LatestFeddItemBuilder extends MultiTypeWidgetBuilder<Feed> {
  @override
  Widget buildWidget(BuildContext context, Feed item, int index) {
    Widget feedWidget;
    if (index % 3 == 0) {
      feedWidget = NewsThumbnailView(item);
    } else {
      feedWidget = NewsListView(feed: item);
    }
    return feedWidget;
  }
}

class ProgressItemBuilder extends MultiTypeWidgetBuilder<LoadingData>{
  @override
  Widget buildWidget(BuildContext context, LoadingData item, int index) {
    return Center(child: ProgressView());
  }

}
