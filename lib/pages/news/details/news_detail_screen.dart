import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/manager/authentication_controller.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/pages/news/details/news_detail_store.dart';
import 'package:samachar_hub/widgets/article_image_widget.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen();

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  ReactionDisposer _disposer;

  @override
  void initState() {
    _disposer = autorun((_) {
      final String message =
          Provider.of<NewsDetailStore>(context, listen: false).message;
      if (null != message)
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
    });
    super.initState();
  }

  @override
  void dispose() {
    if (null != _disposer) _disposer();
    super.dispose();
  }

  Widget _articleDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Consumer<NewsDetailStore>(
        builder: (BuildContext context, NewsDetailStore store, Widget child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                store.feed.title,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 24), //Todo: Use proper style
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
              Opacity(
                opacity: 0.75,
                child: Text(
                  store.feed.description ?? 'No article content available.',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(fontWeight: FontWeight.w500),
                ),
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
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Consumer<NavigationService>(builder: (BuildContext context,
                  NavigationService value, Widget child) {
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
              style: Theme.of(context).textTheme.display2.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: '\n${store.feed.publishedAt}',
                  style: Theme.of(context).textTheme.display3,
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
              color: Theme.of(context).accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(
            store.feed.category,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }

  Builder _buildSourceRow(NewsDetailStore store) {
    return Builder(
      builder: (BuildContext context) {
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
                  ValueListenableBuilder<bool>(
                    builder: (BuildContext context, bool value, Widget child) {
                      return IconButton(
                        icon: Icon(
                          value
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          size: 36,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          store.feed.bookmarked.value = !value;
                        },
                      );
                    },
                    valueListenable: store.feed.bookmarked,
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
    return Consumer2<NewsDetailStore, AuthenticationController>(
      builder: (BuildContext context, NewsDetailStore store,
          AuthenticationController _authenticationManager, Widget child) {
        return Scaffold(
          body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
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
            child: CommentBar(
              userProfileImageUrl: _authenticationManager.currentUser.avatar,
              commentBadgeText: '232',
              likeBagdeText: '123',
              likeNotifier: store.feed.liked,
              onCommentTap: () {},
              onLikeTap: (value) {
                store.feed.liked.value = !value;
              },
              onShareTap: () {
                store.share();
              },
            ),
          ),
        );
      },
    );
  }
}
