import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/pages/news/details/widgets/article_detail.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/utils/extensions.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsFeed feed;
  NewsDetailScreen({this.feed});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<NewsDetailStore>();
    final metaStore = context.read<PostMetaStore>();
    _setupObserver(store, metaStore);
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

  _setupObserver(store, metaStore) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      }),
      autorun((_) {
        final PostMetaModel metaModel = metaStore.postMeta;
        store.updateMeta(metaModel);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewsDetailStore, AuthenticationStore, PostMetaStore>(
      builder: (_, NewsDetailStore store,
          AuthenticationStore _authenticationStore, metaStore, Widget child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: OrientationBuilder(builder: (_, Orientation orientation) {
            switch (orientation) {
              case Orientation.landscape:
                return SafeArea(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: CachedImage(
                          store.feed.image,
                          tag: store.feed.tag,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ArticleDetail(
                                context: context,
                                store: store,
                                metaStore: metaStore)),
                      ),
                    ],
                  ),
                );
                break;
              default:
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.3,
                      flexibleSpace: FlexibleSpaceBar(
                        background: CachedImage(
                          store.feed.image,
                          tag: store.feed.tag,
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: ArticleDetail(
                        context: context,
                        store: store,
                        metaStore: metaStore,
                      ),
                    ),
                  ],
                );
                break;
            }
          }),
          bottomNavigationBar: BottomAppBar(
            child: Observer(
              builder: (_) {
                return IgnorePointer(
                  ignoring: metaStore.postMeta == null,
                  child: CommentBar(
                    userProfileImageUrl: _authenticationStore.user.avatar,
                    commentCountNotifier: store.feed.commentCountNotifier,
                    likeCountNotifier: store.feed.likeCountNotifier,
                    likeNotifier: store.feed.likeNotifier,
                    onCommentTap: () => context
                        .read<NavigationService>()
                        .toCommentsScreen(
                            context: context,
                            title: store.feed.title,
                            postId: store.feed.uuid),
                    onLikeTap: (value) {
                      store.feed.like = !value;
                      if (value) {
                        metaStore
                            .removeLike()
                            .then((v) => store.feed.like = !v);
                      } else {
                        metaStore.postLike().then((v) => store.feed.like = v);
                      }
                    },
                    onShareTap: () {
                      context
                          .read<ShareService>()
                          .share(
                              postId: store.feed.uuid,
                              title: store.feed.title,
                              data: store.feed.link)
                          .catchError((onError) {});
                      metaStore.postShare();
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
