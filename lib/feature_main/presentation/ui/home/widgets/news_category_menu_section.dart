import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsCategoryMenuSection extends StatelessWidget {
  const NewsCategoryMenuSection({
    Key key,
    @required this.newsCategoryUIModels,
  }) : super(key: key);

  final List<NewsCategoryUIModel> newsCategoryUIModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Discover',
          subtitle: 'Get the latest news on your favourite category',
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
              itemCount: newsCategoryUIModels.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var categoryModel = newsCategoryUIModels[index];
                return NewsMenuItem(
                  title: categoryModel.category.title,
                  icon: categoryModel.category.icon,
                  onTap: () => GetIt.I
                      .get<NavigationService>()
                      .toNewsCategoryFeedScreen(
                          context, categoryModel.category),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
