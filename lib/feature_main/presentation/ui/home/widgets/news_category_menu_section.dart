import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsCategoryMenuSection extends StatefulWidget {
  const NewsCategoryMenuSection({
    Key key,
    @required this.newsCategories,
  }) : super(key: key);

  final List<NewsCategoryUIModel> newsCategories;

  @override
  _NewsCategoryMenuSectionState createState() =>
      _NewsCategoryMenuSectionState();
}

class _NewsCategoryMenuSectionState extends State<NewsCategoryMenuSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              itemCount: widget.newsCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var categoryModel = widget.newsCategories[index];
                return NewsMenuItem(
                  title: categoryModel.entity.title,
                  icon: categoryModel.entity.icon,
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

  @override
  bool get wantKeepAlive => true;
}
