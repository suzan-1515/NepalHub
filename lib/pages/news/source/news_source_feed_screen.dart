import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/news/source/widgets/news_source_feed_list.dart';
import 'package:samachar_hub/pages/news/widgets/follow_unfollow_button.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/repository/following_repository.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsSourceFeedScreen extends StatefulWidget {
  const NewsSourceFeedScreen({Key key}) : super(key: key);
  @override
  _NewsSourceFeedScreenState createState() => _NewsSourceFeedScreenState();
}

class _NewsSourceFeedScreenState extends State<NewsSourceFeedScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<NewsSourceFeedStore>();
    _setupObserver(store);
    store.loadInitialData();
    store.loadNewsSources();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
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
        if (message != null) context.showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Consumer2<NewsSourceFeedStore, AuthenticationStore>(
            builder: (_, store, authStore, __) {
          return NewsFilteringAppBar(
            icon: DecorationImage(
              image: CachedNetworkImageProvider(
                store.source.favicon,
                errorListener: () {},
              ),
              fit: BoxFit.cover,
            ),
            followUnFollowButton: ValueListenableBuilder<bool>(
              valueListenable: store.source.followNotifier,
              builder: (context, value, child) => FollowUnFollowButton(
                isFollowed: value,
                onTap: (isFollowed) {
                  store.source.follow = !value;
                  if (isFollowed)
                    context
                        .read<FollowingRepository>()
                        .unFollowSource(store.source)
                        .catchError(
                            (onError) => store.source.follow = isFollowed);
                  else
                    context
                        .read<FollowingRepository>()
                        .followSource(store.source)
                        .catchError(
                            (onError) => store.source.follow = isFollowed);
                },
              ),
            ),
            onSortByChanged: (value) {
              store.setSortBy(value);
            },
            onSourceChanged: (value) {
              store.setSource(value);
            },
            sources: store.sources,
            title: store.source.name,
            initialSortBy: store.sort,
            initialSource: store.selectedSource,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewsSourceFeedList(
                context: context,
                store: store,
                authStore: authStore,
              ),
            ),
          );
        }),
      ),
    );
  }
}
