import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/article_info_widget.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';

class NewsListView extends StatelessWidget {
  final NewsFeedModel feed;
  final PostMetaRepository postMetaRepository;
  final AuthenticationStore authenticationStore;
  final ShareService shareService;
  final NavigationService navigationService;

  NewsListView(
      {@required this.feed,
      @required this.navigationService,
      this.postMetaRepository,
      this.authenticationStore,
      this.shareService});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => navigationService.toFeedDetail(feed, context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FeedSourceSection(feed),
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: FeedTitleDescriptionSection(feed),
                    ),
                    SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 4/3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: ArticleImageWidget(feed.image, tag: feed.tag),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(),
                FeedOptionsSection(
                  article: feed,
                  authenticationStore: authenticationStore,
                  navigationService: navigationService,
                  shareService: shareService,
                  postMetaRepository: postMetaRepository,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
