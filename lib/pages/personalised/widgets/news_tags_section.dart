import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/news_tags_widget.dart';

class NewsTagsSection extends StatelessWidget {
  final NewsTags item;
  const NewsTagsSection({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationService>(
        builder: (context, navigationService, child) {
      return Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: NewsTagsView(
            item: item,
            onTap: (tag) =>
                navigationService.onNewsTagTapped(title: tag, context: context),
          ));
    });
  }
}
