import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class FeedSourceSection extends StatelessWidget {
  final NewsFeedModel article;

  const FeedSourceSection(this.article);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
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

class FeedOptionsSection extends StatelessWidget {
  final NewsFeedModel article;
  final PostMetaRepository postMetaRepository;
  final AuthenticationStore authenticationStore;
  final ShareService shareService;
  final NavigationService navigationService;

  FeedOptionsSection(
      {Key key,
      @required this.article,
      @required this.postMetaRepository,
      @required this.authenticationStore,
      @required this.shareService,
      @required this.navigationService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: article.liked,
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
                    article.liked.value = false;
                    postMetaRepository
                        .removeLike(
                            postId: article.uuid,
                            userId: authenticationStore.user.uId)
                        .then((onValue) => article.liked.value = false)
                        .catchError((onError) => article.liked.value = true);
                  } else {
                    article.liked.value = true;
                    postMetaRepository
                        .postLike(
                            postId: article.uuid,
                            userId: authenticationStore.user.uId)
                        .then((onValue) => article.liked.value = true)
                        .catchError((onError) => article.liked.value = false);
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
                  context: context, title: article.title, postId: article.uuid);
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.shareAlt,
              size: 16,
            ),
            onPressed: () {
              shareService.share(
                  postId: article.uuid,
                  title: article.title,
                  data: article.link);
              postMetaRepository.postShare(
                  postId: article.uuid, userId: authenticationStore.user.uId);
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
  }
}
