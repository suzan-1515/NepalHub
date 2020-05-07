import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';
import 'package:samachar_hub/pages/article/article_store.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/pages.dart';

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

  onCategoryMenuClick({NewsCategoryMenu category, BuildContext context}) {
    Provider.of<HomeScreenStore>(context,listen: false).setPage(1);
    Provider.of<CategoriesStore>(context,listen: false).setActiveTab(category.index);
  }
}
