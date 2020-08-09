import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/news/topics/widgets/news_topic_list.dart';
import 'package:samachar_hub/pages/news/widgets/follow_unfollow_button.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/repository/following_repository.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsTopicFeedScreen extends StatefulWidget {
  const NewsTopicFeedScreen({Key key}) : super(key: key);
  @override
  _NewsTopicFeedScreenState createState() => _NewsTopicFeedScreenState();
}

class _NewsTopicFeedScreenState extends State<NewsTopicFeedScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<NewsTopicFeedStore>();
    _setupObserver(store);
    store.loadInitialData();

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
        child: Consumer2<NewsTopicFeedStore, AuthenticationStore>(
            builder: (_, store, authStore, __) {
          return Observer(
            builder: (_) {
              return NewsFilteringAppBar(
                icon: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                  fit: BoxFit.cover,
                ),
                followUnFollowButton: ValueListenableBuilder<bool>(
                  valueListenable: store.topic.followNotifier,
                  builder: (context, value, child) => FollowUnFollowButton(
                    isFollowed: store.topic.isFollowed,
                    onTap: (isFollowed) {
                      store.topic.follow = !isFollowed;
                      if (isFollowed)
                        context
                            .read<FollowingRepository>()
                            .unFollowTopic(store.topic)
                            .catchError(
                                (onError) => store.topic.follow = isFollowed);
                      else
                        context
                            .read<FollowingRepository>()
                            .followTopic(store.topic)
                            .catchError(
                                (onError) => store.topic.follow = isFollowed);
                    },
                    followerCount: store.topic.followerCount,
                  ),
                ),
                onSortByChanged: (value) {
                  store.setSortBy(value);
                },
                onSourceChanged: (value) {
                  store.setSource(value);
                },
                sources: store.sources,
                title: store.topic.title,
                initialSortBy: store.sort,
                initialSource: store.selectedSource,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsTopicList(
                      context: context, store: store, authStore: authStore),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
