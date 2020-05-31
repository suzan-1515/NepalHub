import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/details/news_detail_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsFeedModel feed;
  NewsDetailScreen({this.feed});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<NewsDetailStore>(context, listen: false);
    final metaStore = Provider.of<PostMetaStore>(context, listen: false);
    _setupObserver(store);
    store.isBookmarked();
    metaStore.loadPostMeta();
    metaStore.postView();

    super.initState();
  }

  @override
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      })
    ];
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(
            apiError: apiError,
          );
        },
      );
  }

  Widget _articleDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Consumer<NewsDetailStore>(
        builder: (_, NewsDetailStore store, Widget child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                store.feed.title,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w600), //Todo: Use proper style
              ),
              SizedBox(
                height: 16,
              ),
              _buildSourceRow(store),
              SizedBox(
                height: 16,
              ),
              _buildAuthorRow(store, context),
              SizedBox(
                height: 16,
              ),
              Text(
                store.feed.description ?? 'No article content available.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              _buildAdRow(),
              _buildReadMoreRow(context, store),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAdRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 60,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(child: Text('Ad section')),
          ),
        ],
      ),
    );
  }

  Widget _buildReadMoreRow(BuildContext context, NewsDetailStore store) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Text(
              'To read the complete article, please open this article in your web browser app.',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Consumer<NavigationService>(
                  builder: (_, NavigationService value, Widget child) {
                return OutlineButton.icon(
                  onPressed: () {
                    value.onOpenLink(
                        store.feed.title, store.feed.link, context);
                  },
                  icon: Icon(FontAwesomeIcons.link),
                  label: Text('Read'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorRow(NewsDetailStore store, BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidUserCircle),
        SizedBox(width: 6),
        RichText(
          text: TextSpan(
              text: 'By ${store.feed.author}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: '\n${store.feed.publishedAt}',
                  style: Theme.of(context).textTheme.caption,
                )
              ]),
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: SizedBox(
            width: 8,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(
            store.feed.category,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  Builder _buildSourceRow(NewsDetailStore store) {
    return Builder(
      builder: (_) {
        final String faviconUrl = store.feed.sourceFavicon;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  height: 48,
                  width: 48,
                  child: ArticleImageWidget(faviconUrl),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Article\nPublished on\n${store.feed.source}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      return IconButton(
                        icon: Icon(
                          store.bookmarkStatus
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          size: 36,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          if (store.bookmarkStatus) {
                            store.feed.bookmarked.value = false;
                            store.removeBookmarkedFeed();
                          } else {
                            store.feed.bookmarked.value = true;
                            store.bookmarkFeed();
                          }
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Bookmark', textAlign: TextAlign.center),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NewsDetailStore, AuthenticationStore>(
      builder: (_, NewsDetailStore store,
          AuthenticationStore _authenticationStore, Widget child) {
        return Scaffold(
          body: OrientationBuilder(builder: (_, Orientation orientation) {
            switch (orientation) {
              case Orientation.landscape:
                return SafeArea(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          child: ArticleImageWidget(store.feed.image,
                              tag: store.feed.tag)),
                      Expanded(
                        child: SingleChildScrollView(
                            child: _articleDetails(context)),
                      ),
                    ],
                  ),
                );
                break;
              default:
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: BackButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
                      flexibleSpace: FlexibleSpaceBar(
                        background: ArticleImageWidget(store.feed.image,
                            tag: store.feed.tag),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _articleDetails(context),
                    ),
                  ],
                );
                break;
            }
          }),
          bottomNavigationBar: BottomAppBar(
            child: Consumer3<NavigationService, ShareService, PostMetaStore>(
              builder: (_, NavigationService navigationService, shareService,
                  metaStore, Widget child) {
                return Observer(
                  builder: (_) {
                    return CommentBar(
                      userProfileImageUrl: _authenticationStore.user.avatar,
                      commentsCount:
                          metaStore.postMeta?.commentCount?.toString() ?? '0',
                      likesCount:
                          metaStore.postMeta?.likeCount?.toString() ?? '0',
                      isLiked: store.feed.liked.value,
                      onCommentTap: () {
                        navigationService.onViewCommentsTapped(
                            context: context,
                            title: store.feed.title,
                            postId: store.feed.uuid);
                      },
                      onLikeTap: (value) {
                        if (value) {
                          store.feed.liked.value = false;
                          metaStore.removeLike().then((value) {
                            store.feed.liked.value = !value;
                          });
                        } else {
                          store.feed.liked.value = true;
                          metaStore.postLike().then((value) {
                            store.feed.liked.value = value;
                          });
                        }
                      },
                      onShareTap: () {
                        if (store.feed != null)
                          shareService.share(
                              postId: store.feed.uuid,
                              title: store.feed.title,
                              data: store.feed.link);
                        metaStore.postShare();
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
