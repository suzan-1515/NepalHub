import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/widgets/news_source_menu_section.dart';

class NewsSourceMenuSection extends StatelessWidget {
  final List<FeedSource> items;
  const NewsSourceMenuSection({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeScreenStore, NavigationService>(
        builder: (context, homeScreenStore, navigationService, child) {
      return LimitedBox(
        maxHeight: 120,
        child: Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: NewsSourceMenuView(
                items: items,
                onMenuTap: (sourceMenu) =>
                    navigationService.onNewsSourceMenuTapped(
                      source: sourceMenu,
                      context: context,
                    ),
                onViewAllTap: () => navigationService.onSourceViewAllTapped())),
      );
    });
  }
}
