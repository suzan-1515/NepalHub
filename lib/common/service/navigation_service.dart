import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/news/details/news_details.dart';
import 'package:samachar_hub/pages/news/sources/news_source_screen.dart';
import 'package:samachar_hub/pages/news/sources/news_source_store.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/widgets/webview_widget.dart';

class NavigationService {
  onFeedClick(Feed article, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Provider<NewsDetailStore>(
          create: (_) => NewsDetailStore(article, NewsDetailService()),
          child: Consumer<NewsDetailStore>(
            builder: (context, store, _) => NewsDetailScreen(),
          ),
        ),
      ),
    );
  }

  onOpenLink(String title, String url, BuildContext context) {
    print('open link: $title');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Webview(
          title: title,
          url: url,
        ),
      ),
    );
  }

  onNewsCategoryMenuTapped(
      {@required NewsCategoryMenu category, @required BuildContext context}) {
    Provider.of<HomeScreenStore>(context, listen: false).setPage(1);
    Provider.of<CategoriesStore>(context, listen: false)
        .setActiveTab(category.index);
  }

  onNewsTagTapped({@required String title, @required BuildContext context}) {
    print('Tag selected: $title');
  }

  onNewsSourceMenuTapped(
      {@required FeedSource source, @required BuildContext context}) {
    print('Tag selected: $source.name');
  }

  onSourceViewAllTapped({@required BuildContext context}) {
    print('onSourceViewAllTapped');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProxyProvider<NewsRepository, NewsSourceStore>(
          update: (BuildContext context, NewsRepository value,
                  NewsSourceStore previous) =>
              NewsSourceStore(value),
          dispose: (context, value) => value.dispose(),
          child: NewsSourceScreen(),
        ),
      ),
    );
  }
}
