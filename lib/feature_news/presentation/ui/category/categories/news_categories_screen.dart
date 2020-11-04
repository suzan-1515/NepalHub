import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/widgets/news_category_list.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsProvider.categoryBlocProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News Categories',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: NewsCategoryList(),
          ),
        ),
      ),
    );
  }
}
