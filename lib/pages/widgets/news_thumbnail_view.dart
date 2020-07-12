import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/article_info_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';

class NewsThumbnailView extends StatelessWidget {
  final NewsFeedModel feed;
  final AuthenticationStore authenticationStore;
  NewsThumbnailView({@required this.feed, @required this.authenticationStore});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              context.read<NavigationService>().toFeedDetail(feed, context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FeedSourceSection(feed),
                SizedBox(height: 8),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    child: ArticleImageWidget(feed.image, tag: feed.tag),
                  ),
                ),
                SizedBox(height: 8),
                FeedTitleDescriptionSection(feed),
                SizedBox(height: 8),
                Divider(),
                FeedOptionsSection(
                  article: feed,
                  authenticationStore: authenticationStore,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
