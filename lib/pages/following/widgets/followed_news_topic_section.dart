import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/pages/following/widgets/followed_news_topic_list.dart';
import 'package:samachar_hub/pages/following/widgets/section_title.dart';

class FollowedNewsTopicSection extends StatelessWidget {
  const FollowedNewsTopicSection({
    Key key,
    @required this.context,
    @required this.favouritesStore,
  }) : super(key: key);

  final BuildContext context;
  final FollowingStore favouritesStore;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SectionTitle(context: context, title: 'News Topics'),
            SizedBox(
              height: 8,
            ),
            Flexible(
                fit: FlexFit.loose,
                child: FollowedNewsTopicList(favouritesStore: favouritesStore)),
            SizedBox(
              height: 8,
            ),
            // Divider(),
            // ViewAllButton(context: context, onTap: () {}),
          ],
        ),
      ),
    );
  }
}
