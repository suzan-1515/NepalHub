import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';
import 'package:samachar_hub/pages/article/article_store.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/widgets/webview_widget.dart';

class NavigationService {
  onFeedClick(Feed article, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Provider<ArticleStore>(
          create: (_) => ArticleStore(article),
          child: Consumer<ArticleStore>(
            builder: (context, store, _) => ArticleViewScreen(store),
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

  onSourceViewAllTapped() {
    print('Source view all tapped.');
  }
}
