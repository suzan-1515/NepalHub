import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsSourceMenuSection extends StatelessWidget {
  const NewsSourceMenuSection({
    Key key,
    @required this.newsSources,
  }) : super(key: key);

  final List<NewsSourceEntity> newsSources;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Featured Sources',
          onTap: () => GetIt.I
              .get<NavigationService>()
              .toFollowedNewsSourceScreen(context),
        ),
        LimitedBox(
          maxHeight: 100,
          child: Container(
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              itemExtent: 120,
              primary: false,
              itemCount: newsSources.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var sourceModel = newsSources[index];
                return NewsMenuItem(
                  title: sourceModel.title,
                  icon: sourceModel.icon,
                  onTap: () => GetIt.I
                      .get<NavigationService>()
                      .toNewsSourceFeedScreen(
                          context: context, source: sourceModel),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
