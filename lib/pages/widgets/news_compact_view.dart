import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';

import 'article_info_widget.dart';

class NewsCompactView extends StatelessWidget {
  NewsCompactView(this.feed);

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    // Todo: Not what I had in mind!
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
              child: IntrinsicHeight(
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ArticleImageWidget(feed.image,
                          tag: feed.uuid + feed.id),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.transparent,
                            Colors.white70,
                            Colors.white
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FeedSourceSection(feed),
                            SizedBox(height: 8),
                            FeedTitleDescriptionSection(feed),
                          ],
                        ),
                      ),
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
