import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/related_news/widgets/related_list_item.dart';

class RelatedNewsList extends StatelessWidget {
  const RelatedNewsList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<NewsFeedEntity> data;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Heading(
                title: 'Related news',
              ),
              SizedBox(
                height: 8,
              ),
            ] +
            List<Widget>.generate((data.length * 2) - 1, (index) {
              if (index.isOdd) return Divider();
              final feed = data[index ~/ 2];
              return RelatedNewsListItem(
                feed: feed,
                onTap: () => NewsDetailScreen.navigate(feed, context),
              );
            }) +
            [
              SizedBox(
                height: 8,
              )
            ],
      ),
    );
  }
}
