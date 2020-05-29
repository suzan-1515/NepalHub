import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/widgets/news_category_menu_item.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';
import 'package:samachar_hub/services/services.dart';

class NewsCategoryMenuSection extends StatelessWidget {
  final List<NewsCategoryMenuModel> items;
  const NewsCategoryMenuSection({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeScreenStore, NavigationService>(
        builder: (context, homeScreenStore, navigationService, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SectionHeadingView(
            title: 'Discover',
            subtitle: 'Get the latest news on your favourite category',
            onTap: () => homeScreenStore.setPage(1),
          ),
          LimitedBox(
            maxHeight: 100,
            child: Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ListView.builder(
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NewsCategoryMenuItem(
                      category: items[index],
                      onTap: (categoryMenu) =>
                          navigationService.onNewsCategoryMenuTapped(
                        category: categoryMenu,
                        context: context,
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
