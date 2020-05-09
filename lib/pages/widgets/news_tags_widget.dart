import 'package:flutter/material.dart';
import 'package:samachar_hub/data/dto/news_dto.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';

class NewsTagsView extends StatelessWidget {
  final NewsTags item;
  final Function onTap;

  const NewsTagsView({Key key, @required this.item, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(
          item.tags.length,
          (index) => NewsTagItem(
                title: item.tags[index],
                onTap: onTap,
              )),
    );
  }
}
