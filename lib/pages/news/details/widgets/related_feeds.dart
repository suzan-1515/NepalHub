import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/news/details/widgets/related_feed_heading.dart';
import 'package:samachar_hub/pages/news/related_news/widgets/related_list_item.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/stores/stores.dart';

class RelatedNews extends StatelessWidget {
  final NewsDetailStore store;

  const RelatedNews({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              RelatedFeedHeading(),
              SizedBox(
                height: 8,
              ),
            ] +
            List<Widget>.generate((store.relatedFeeds.length * 2) - 1, (index) {
              if (index.isOdd) return Divider();
              final feed = store.relatedFeeds[index ~/ 2];
              return RelatedNewsListItem(
                feed: feed,
                onTap: () => context
                    .read<NavigationService>()
                    .toFeedDetail(feed, context),
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
