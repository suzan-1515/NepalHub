import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/icon_badge_widget.dart';

class NewsFeedCardSourceCategory extends StatelessWidget {
  final String sourceIcon;
  final String source;
  final String publishedDate;
  final String category;

  const NewsFeedCardSourceCategory({
    @required this.sourceIcon,
    @required this.source,
    @required this.publishedDate,
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: sourceIcon,
            placeholder: (context, _) => Icon(FontAwesomeIcons.image),
            errorWidget: (context, url, error) => Icon(FontAwesomeIcons.image),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        RichText(
          text: TextSpan(
            text: source,
            style: Theme.of(context).textTheme.subtitle2,
            children: <TextSpan>[
              TextSpan(
                  text: '\n$publishedDate',
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
        Spacer(),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(12)),
          child: Text(
            category,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}

class NewsFeedCardTitleDescription extends StatelessWidget {
  final String title;
  final String description;

  const NewsFeedCardTitleDescription({
    @required this.title,
    @required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title ?? '',
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
          description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class NewsFeedOptions extends StatefulWidget {
  const NewsFeedOptions({
    Key key,
    @required this.feed,
    @required this.authStore,
  }) : super(key: key);

  final NewsFeed feed;
  final AuthenticationStore authStore;

  @override
  _NewsFeedOptionsState createState() => _NewsFeedOptionsState();
}

class _NewsFeedOptionsState extends State<NewsFeedOptions> {
  ValueNotifier<bool> _likeProgressNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _likeProgressNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: 0.6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: widget.feed.likeNotifier,
            builder: (_, value, Widget child) {
              return ValueListenableBuilder(
                valueListenable: _likeProgressNotifier,
                builder: (_, isLikeProgress, Widget child) {
                  return IgnorePointer(
                    ignoring: isLikeProgress,
                    child: IconButton(
                      icon: value
                          ? Icon(
                              FontAwesomeIcons.solidThumbsUp,
                              size: 16,
                              color: Colors.blue,
                            )
                          : Icon(
                              FontAwesomeIcons.thumbsUp,
                              size: 16,
                            ),
                      onPressed: () {
                        _likeProgressNotifier.value = true;
                        final authStore = context.read<AuthenticationStore>();
                        if (!authStore.isLoggedIn)
                          return context
                              .read<NavigationService>()
                              .loginRedirect(context);

                        final isLiked = widget.feed.isLiked;
                        widget.feed.like = !value;
                        if (isLiked) {
                          context
                              .read<PostMetaRepository>()
                              .removeLike(
                                postId: widget.feed.uuid,
                                userId: authStore.user.uId,
                              )
                              .catchError(
                                  (onError) => widget.feed.like = isLiked)
                              .whenComplete(
                                  () => _likeProgressNotifier.value = false);
                        } else {
                          context
                              .read<PostMetaRepository>()
                              .postLike(
                                postId: widget.feed.uuid,
                                userId: authStore.user.uId,
                              )
                              .catchError(
                                  (onError) => widget.feed.like = isLiked)
                              .whenComplete(
                                  () => _likeProgressNotifier.value = false);
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: widget.feed.commentCountNotifier,
            builder: (context, value, child) {
              return (value > 0)
                  ? IconBadge(
                      iconData: FontAwesomeIcons.comment,
                      badgeText: value.toString(),
                      onTap: () =>
                          context.read<NavigationService>().toCommentsScreen(
                                context: context,
                                title: widget.feed.title,
                                postId: widget.feed.uuid,
                              ),
                    )
                  : IconButton(
                      icon: Icon(
                        FontAwesomeIcons.comment,
                        size: 16,
                      ),
                      onPressed: () =>
                          context.read<NavigationService>().toCommentsScreen(
                                context: context,
                                title: widget.feed.title,
                                postId: widget.feed.uuid,
                              ),
                    );
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.shareAlt,
              size: 16,
            ),
            onPressed: () {
              context.read<ShareService>().share(
                  postId: widget.feed.uuid,
                  title: widget.feed.title,
                  data: widget.feed.link);
              if (widget.authStore.isLoggedIn)
                context.read<PostMetaRepository>().postShare(
                    postId: widget.feed.uuid,
                    userId: widget.authStore.user.uId);
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
