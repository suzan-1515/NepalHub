import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/widgets/news_category_list_item.dart';

class NewsCategoryListBuilder extends StatelessWidget {
  const NewsCategoryListBuilder({
    Key key,
    @required this.data,
    @required this.onRefresh,
  }) : super(key: key);

  final List<NewsCategoryEntity> data;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FadeInUp(
        duration: Duration(milliseconds: 200),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: data.length,
          itemBuilder: (context, index) =>
              NewsCategoryListItem(category: data[index]),
          separatorBuilder: (_, int index) => Divider(),
        ),
      ),
    );
  }
}
