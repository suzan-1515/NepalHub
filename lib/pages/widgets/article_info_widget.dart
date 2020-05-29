import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class DefaultFeedInfoWidget extends StatelessWidget {
  DefaultFeedInfoWidget(this.feed);

  final NewsFeedModel feed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FeedSourceSection(feed),
        SizedBox(height: 16),
        FeedTitleDescriptionSection(feed),
        SizedBox(height: 8),
        Divider(),
        FeedOptionsSection(
          article: feed,
        )
      ],
    );
  }
}

class FeedSourceSection extends StatelessWidget {
  final NewsFeedModel article;

  const FeedSourceSection(this.article);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              color: Colors.grey[100],
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: article.sourceFavicon,
                placeholder: (context, _) => Icon(FontAwesomeIcons.image),
                errorWidget: (context, url, error) =>
                    Icon(FontAwesomeIcons.image),
              ),
            ),
          ),
          SizedBox(
            width: 8,
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: article.source,
              style: Theme.of(context).textTheme.subtitle2,
              children: <TextSpan>[
                TextSpan(
                    text: '\n${article.publishedAt}',
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              article.category,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}

class FeedTitleDescriptionSection extends StatelessWidget {
  final NewsFeedModel article;

  const FeedTitleDescriptionSection(this.article);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          article.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class FeedOptionsSection extends StatefulWidget {
  final NewsFeedModel article;

  FeedOptionsSection({Key key, this.article}) : super(key: key);

  @override
  _FeedOptionsSectionState createState() => _FeedOptionsSectionState();
}

class _FeedOptionsSectionState extends State<FeedOptionsSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer4<PostMetaRepository, AuthenticationStore, ShareService,
        NavigationService>(
      builder: (context, postMetaStore, authenticationStore, shareService,
          navigationService, child) {
        return Opacity(
          opacity: 0.6,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: widget.article.liked,
                builder: (context, value, child) {
                  return IconButton(
                    icon: Icon(
                      value
                          ? FontAwesomeIcons.solidThumbsUp
                          : FontAwesomeIcons.thumbsUp,
                      size: 16,
                    ),
                    onPressed: () async {
                      if (!authenticationStore.isLoggedIn)
                        return navigationService.loginRedirect(context);
                      if (value) {
                        widget.article.liked.value = false;
                        postMetaStore
                            .removeLike(
                                postId: widget.article.uuid,
                                userId: authenticationStore.user.uId)
                            .then(
                                (onValue) => widget.article.liked.value = false)
                            .catchError(
                                (onError) => widget.article.liked.value = true);
                      } else {
                        widget.article.liked.value = true;
                        postMetaStore
                            .postLike(
                                postId: widget.article.uuid,
                                userId: authenticationStore.user.uId)
                            .then(
                                (onValue) => widget.article.liked.value = true)
                            .catchError(
                                (onError) => widget.article.liked.value = false);
                      }
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.comment,
                  size: 16,
                ),
                onPressed: () {
                  navigationService.onViewCommentsTapped(
                      context: context,
                      title: widget.article.title,
                      postId: widget.article.uuid);
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.shareAlt,
                  size: 16,
                ),
                onPressed: () {
                  shareService.share(
                      postId: widget.article.uuid,
                      title: widget.article.title,
                      data: widget.article.link);
                },
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
