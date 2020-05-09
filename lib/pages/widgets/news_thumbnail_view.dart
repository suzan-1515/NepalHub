import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/article_info_widget.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';

class NewsThumbnailView extends StatelessWidget {
  NewsThumbnailView(this.feed);

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Consumer<NavigationService>(
        builder: (context, navigationService, child) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => navigationService.onFeedClick(feed, context),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                        child:
                            ArticleImageWidget(feed.image, tag: feed.tag),
                      ),
                    ),
                    SizedBox(height: 8),
                    FeedTitleDescriptionSection(feed),
                    SizedBox(height: 8),
                    Divider(),
                    FeedOptionsSection(
                      article: feed,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
