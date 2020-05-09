import 'package:flutter/material.dart';
import 'package:samachar_hub/data/dto/news_dto.dart';
import 'package:samachar_hub/pages/widgets/news_source_menu_item.dart';

class NewsSourceMenuView extends StatelessWidget {
  final List<FeedSource> items;
  final Function onMenuTap;
  final Function onViewAllTap;

  const NewsSourceMenuView(
      {Key key,
      @required this.items,
      @required this.onMenuTap,
      @required this.onViewAllTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return NewsSourceMenuItem(
                  source: items[index],
                  onTap: onMenuTap,
                );
              }),
        ),
        Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onViewAllTap(),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Text(
                'All',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.blue),
              ),
            ),
          ),
        )
      ],
    );
  }
}
