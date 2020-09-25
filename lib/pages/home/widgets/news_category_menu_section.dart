import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/core/widgets/news_category_horz_list_item.dart';

class NewsCategoryMenuSection extends StatelessWidget {
  final List<NewsCategory> items;
  const NewsCategoryMenuSection({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Discover',
          subtitle: 'Get the latest news on your favourite category',
          onTap: () => context
              .read<NavigationService>()
              .toFollowedNewsCategoryScreen(context),
        ),
        LimitedBox(
          maxHeight: 100,
          child: Container(
            color: Theme.of(context).cardColor,
            child: ListView.builder(
                itemExtent: 120,
                primary: false,
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var categoryModel = items[index];
                  return NewsCategoryHorzListItem(
                    context: context,
                    name: categoryModel.name,
                    icon: categoryModel.icon,
                    onTap: () => context
                        .read<NavigationService>()
                        .toNewsCategoryFeedScreen(
                          context,
                          categoryModel,
                        ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
