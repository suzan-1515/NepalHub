import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsCategoryMenuSection extends StatelessWidget {
  const NewsCategoryMenuSection({
    Key key,
    @required this.newsCategories,
  }) : super(key: key);

  final List<NewsCategoryEntity> newsCategories;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Top Categories',
          onTap: () => GetIt.I
              .get<NavigationService>()
              .toFollowedNewsCategoryScreen(context),
        ),
        LimitedBox(
          maxHeight: 100,
          child: Container(
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              itemExtent: 120,
              primary: false,
              itemCount: newsCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var categoryModel = newsCategories[index];
                return NewsMenuItem(
                  title: categoryModel.title,
                  icon: categoryModel.icon,
                  onTap: () => GetIt.I
                      .get<NavigationService>()
                      .toNewsCategoryFeedScreen(context, categoryModel),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
