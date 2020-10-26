import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsSourceMenuSection extends StatelessWidget {
  const NewsSourceMenuSection({
    Key key,
    @required this.newsSourceUIModels,
  }) : super(key: key);

  final List<NewsSourceUIModel> newsSourceUIModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeading(
          title: 'Discover',
          subtitle: 'Get the latest news on your favourite source',
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
              itemCount: newsSourceUIModels.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var sourceModel = newsSourceUIModels[index];
                return NewsMenuItem(
                  title: sourceModel.source.title,
                  icon: sourceModel.source.icon,
                  onTap: () => GetIt.I
                      .get<NavigationService>()
                      .toNewsSourceFeedScreen(
                          context: context, source: sourceModel.source),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
