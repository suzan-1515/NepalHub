import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/widgets/news_category_feed_header.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/widgets/news_category_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsCategoryFeedScreen extends StatelessWidget {
  final NewsCategoryEntity newsCategoryEntity;
  const NewsCategoryFeedScreen({Key key, @required this.newsCategoryEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.categoryFeedBlocProvider(
      newsCategoryUIModel: newsCategoryEntity,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: NewsFilteringAppBar(
            header: const NewsCategoryFeedHeader(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const NewsCategoryFeedList(),
            ),
          ),
        ),
      ),
    );
  }
}
